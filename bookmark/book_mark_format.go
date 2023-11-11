package main

import (
	"encoding/json"
	"fmt"
	"os"
	"os/user"
	"path/filepath"
	"strings"
	"time"
)

var dirPath string

func main() {
	start := time.Now()
	// ユーザ情報取得。
	usr, err := user.Current()
	if err != nil {
		fmt.Println("Error getting user:", err)
		return
	}
	// ホームディレクトリ取得。
	homeDir := usr.HomeDir

	// ブックマークJsonパス。
	bookmarkJSON := "/AppData/Local/Google/Chrome/User Data/Default/Bookmarks"

	// ブックマークJsonのパス作成。
	JsonPath := filepath.Join(homeDir, bookmarkJSON)

	// JSONの読み込み開始。
	file, err := os.Open(JsonPath)
	if err != nil {
		fmt.Println("Error decoding JSON file:", err)
		return
	}
	defer file.Close()

	// JSONデータをインターフェースとしてデコード。
	var jsonData interface{}
	decoder := json.NewDecoder(file)
	err = decoder.Decode(&jsonData)
	if err != nil {
		fmt.Println("Error decoding JSON:", err)
		return
	}

	// bookmarkディレクトリの存在確認。
	dirPath = homeDir + "/bookmark"
	if _, err := os.Stat(dirPath); !os.IsNotExist(err) {
		if err := os.RemoveAll(dirPath); err != nil {
			fmt.Println("Error removing dir:", err)
		}
	}

	// bookmarkディレクトリ作成。
	if err := os.Mkdir(dirPath, 0755); err != nil {
		fmt.Println("Error create dir:", err)
	}

	// ブックマークをNameごとにファイルに保存する。
	j, ok := jsonData.(map[string]interface{})
	if !ok {
		fmt.Println("Error jsonData type assertion:", err)
	}
	roots, ok := j["roots"]
	if !ok {
		fmt.Println("Error roots type assertion:", err)
	}
	r := roots.(map[string]interface{})
	for _, folderData := range r {
		extractUrls(folderData)
	}
	fmt.Println("===== Done format bookmark json =====")
	end := time.Now()
	total := end.Sub(start)
	fmt.Println("total: ", total)
}

func extractUrls(folderData interface{}) {
	f := folderData.(map[string]interface{})
	children, ok := f["children"]
	if !ok {
		fmt.Println("Error children type assertion:")
	}
	c := children.([]interface{})
	for _, folderData := range c {
		f := folderData.(map[string]interface{})

		n, ok := f["name"]
		if !ok {
			continue
		}
		nStr := n.(string)
		name := replaceFilename(nStr)

		u, ok := f["url"]
		if !ok {
			extractUrls(folderData)
			continue
		}
		uStr := u.(string)
		url := []byte(uStr)

		bookmarkFile := filepath.Join(dirPath, name)
		err := os.WriteFile(bookmarkFile, url, 0755)
		if err != nil {
			fmt.Println("Error create bookmark file:", err)
		}
	}
	return
}

func replaceFilename(name string) string {
	// Windowsのファイル名に使用できない文字
	invalidChars := []string{"<", ">", ":", "\"", "/", "\\", "|", "?", "*", " "}

	// 各文字を "_" に置換
	for _, char := range invalidChars {
		name = strings.ReplaceAll(name, char, "_")
	}

	return name
}
