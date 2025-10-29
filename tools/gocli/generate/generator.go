package main

import (
	"fmt"
	"log"
	"os"
	"strings"
	"sync"
	"text/template"

	"gopkg.in/yaml.v3"
)

type Data struct {
	Commands []string `yaml:"commands"`
}

func main() {
	// YAML読み込み
	var data Data
	b, err := os.ReadFile("definition/commands.yml")
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

	var wg sync.WaitGroup
	results := make(chan string, len(tmplMap)) // ✅ 結果を受け取るチャネルを作成

	for tmplName, tmplExt := range tmplMap {
		wg.Add(1)
		go func(tmplName, tmplExt string) {
			defer wg.Done()

			templatePath := fmt.Sprintf("template/%s.tmpl", tmplName)
			outputPath := fmt.Sprintf("output/%s.%s", tmplName, tmplExt)
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

			results <- fmt.Sprintf("✅ %s done", tmplName) // ✅ 完了メッセージを送信
		}(tmplName, tmplExt)
	}

	// 別goroutineでwg完了を待ち、チャネルを閉じる
	go func() {
		wg.Wait()
		close(results)
	}()

	// チャネルから結果を順次受け取る
	for msg := range results {
		fmt.Println(msg)
	}

	log.Println("🏁 all templates processed successfully")
}
