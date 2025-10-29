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
	wg.Add(len(tmplMap))

	for tmplName, tmplExt := range tmplMap {
		go func(tmplName, tmplExt string) {
			defer wg.Done()

			templatePath := fmt.Sprintf("template/%s.tmpl", tmplName)
			outputPath := fmt.Sprintf("output/%s.%s", tmplName, tmplExt)

			fmt.Println("Processing:", templatePath)

			// 各goroutine内でテンプレート処理
			tmpl := template.Must(template.New(tmplName + ".tmpl").Funcs(funcMap).ParseFiles(templatePath))

			out, err := os.Create(outputPath)
			if err != nil {
				log.Printf("❌ %s: %v\n", tmplName, err)
				return
			}
			defer out.Close()

			if err := tmpl.ExecuteTemplate(out, tmplName+".tmpl", data); err != nil {
				log.Printf("❌ %s: %v\n", tmplName, err)
				return
			}

			fmt.Printf("✅ %s done\n", tmplName)
		}(tmplName, tmplExt)
	}

	wg.Wait()
	log.Println("🏁 all templates processed successfully")
}
