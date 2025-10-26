package main

import (
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

	// テンプレート読み込み（修正版）
	switchTmpl := template.Must(template.New("").Funcs(funcMap).ParseFiles("template/switch.tmpl"))

	switchOut, err := os.Create("output/switch.go")
	if err != nil {
		log.Fatal(err)
	}
	defer switchOut.Close()

	if err := switchTmpl.ExecuteTemplate(switchOut, "switch.tmpl", data); err != nil {
		log.Fatal(err)
	}

	// テンプレート読み込み（修正版）
	tmpl2 := template.Must(template.New("").Funcs(funcMap).ParseFiles("template/alias.tmpl"))

	out2, err := os.Create("output/alias.sh")
	if err != nil {
		log.Fatal(err)
	}
	defer out2.Close()

	if err := tmpl2.ExecuteTemplate(out2, "alias.tmpl", data); err != nil {
		log.Fatal(err)
	}

	log.Println("✅ generate done")
}
