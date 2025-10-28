package main

import (
	"fmt"
	"log"
	"os"
	"strings"
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

	// 関数マップ登録
	funcMap := template.FuncMap{
		"title": func(s string) string {
			if s == "" {
				return s
			}
			return strings.ToUpper(s[:1]) + s[1:]
		},
	}

	// テンプレート名と拡張子のマップ
	tmplMap := map[string]string{
		"switch": "go",
		"alias":  "sh",
	}

	for tmplName, tmplExt := range tmplMap {
		templatePath := fmt.Sprintf("template/%s.tmpl", tmplName)
		outputPath := fmt.Sprintf("output/%s.%s", tmplName, tmplExt)

		fmt.Println("Processing:", templatePath)

		// ✅ テンプレート名を指定してNew()
		tmpl := template.Must(template.New(tmplName + ".tmpl").Funcs(funcMap).ParseFiles(templatePath))

		out, err := os.Create(outputPath)
		if err != nil {
			log.Fatal(err)
		}
		defer out.Close()

		// ✅ tmplName+".tmpl" を使ってテンプレートを実行
		if err := tmpl.ExecuteTemplate(out, tmplName+".tmpl", data); err != nil {
			log.Fatal(err)
		}
	}

	log.Println("✅ generate done")
}
