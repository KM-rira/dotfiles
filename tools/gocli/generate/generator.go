package main

import (
	"fmt"
	"log"
	"os"
	"path/filepath"
	"runtime"
	"strings"
	"sync"
	"text/template"

	"github.com/panjf2000/ants/v2"
	"gopkg.in/yaml.v3"
)

type Data struct {
	Commands []string `yaml:"commands"`
}

func main() {
	// YAML読み込み
	var data Data
	_, exePath, _, ok := runtime.Caller(0)
	if !ok {
		log.Fatal("❌ failed to get runtime caller")
	}
	exeDir := filepath.Dir(exePath)

	ymlPath := filepath.Join(exeDir, "definition", "commands.yml")

	// YAML読み込み
	b, err := os.ReadFile(ymlPath)
	if err != nil {
		log.Fatal(err)
	}
	if err := yaml.Unmarshal(b, &data); err != nil {
		log.Fatal(err)
	}

	funcMap := template.FuncMap{
		"title": func(s string) string {
			if s == "" {
				return s
			}
			return strings.ToUpper(s[:1]) + s[1:]
		},
	}

	tmplMap := map[string]string{
		"switch": "go",
		"alias":  "sh",
	}

	results := make(chan string, len(tmplMap))
	var wg sync.WaitGroup

	// ✅ CPU数に応じてプールサイズを設定
	maxCPU := runtime.NumCPU()
	poolSize := maxCPU * 2 // 一般的には 2×CPU 程度がバランス良い
	log.Printf("🧠 Detected %d CPU cores, pool size set to %d\n", maxCPU, poolSize)

	pool, _ := ants.NewPoolWithFunc(poolSize, func(i interface{}) {
		defer wg.Done()

		args := i.(map[string]string)
		tmplName := args["name"]
		tmplExt := args["ext"]

		templatePath := fmt.Sprintf("%s/template/%s.tmpl", exeDir, tmplName)
		outputPath := fmt.Sprintf("%s/output/%s.%s", exeDir, tmplName, tmplExt)
		tmpl := template.Must(template.New(tmplName + ".tmpl").Funcs(funcMap).ParseFiles(templatePath))

		out, err := os.Create(outputPath)
		if err != nil {
			results <- fmt.Sprintf("❌ %s: %v", tmplName, err)
			return
		}
		defer out.Close()

		if err := tmpl.ExecuteTemplate(out, tmplName+".tmpl", data); err != nil {
			results <- fmt.Sprintf("❌ %s: %v", tmplName, err)
			return
		}

		results <- fmt.Sprintf("✅ %s done", tmplName)
	})
	defer pool.Release()

	// タスク投入
	for tmplName, tmplExt := range tmplMap {
		wg.Add(1)
		_ = pool.Invoke(map[string]string{
			"name": tmplName,
			"ext":  tmplExt,
		})
	}

	// 結果集約
	go func() {
		wg.Wait()
		close(results)
	}()

	for msg := range results {
		fmt.Println(msg)
	}

	log.Println("🏁 all templates processed successfully")
}
