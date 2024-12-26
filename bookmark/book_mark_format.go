package main

import (
	"encoding/json"
	"fmt"
	"os"
	"os/user"
	"path/filepath"
	"runtime"
	"strings"
	"time"
)

var dirPath string

func main() {
	start := time.Now()

	// ユーザ情報取得
	usr, err := user.Current()
	if err != nil {
		fmt.Println("Error getting user:", err)
		return
	}
	homeDir := usr.HomeDir

	// OSに応じたブックマークJSONのパス設定
	var bookmarkJSON string
	switch runtime.GOOS {
	case "windows":
		bookmarkJSON = "AppData/Local/Google/Chrome/User Data/Default/Bookmarks"
	case "darwin": // Mac OSは"darwin"として検出される
		bookmarkJSON = "Library/Application Support/Google/Chrome/Default/Bookmarks"
	case "linux":
		bookmarkJSON = ".config/google-chrome/Default/Bookmarks"
	default:
		fmt.Println("Unsupported operating system:", runtime.GOOS)
		return
	}

	// ブックマークJSONのパス作成
	JsonPath := filepath.Join(homeDir, bookmarkJSON)

	// JSONの読み込み開始
	file, err := os.Open(JsonPath)
	if err != nil {
		fmt.Println("Error opening JSON file:", err)
		return
	}
	defer file.Close()

	// JSONデータをインターフェースとしてデコード
	var jsonData interface{}
	decoder := json.NewDecoder(file)
	err = decoder.Decode(&jsonData)
	if err != nil {
		fmt.Println("Error decoding JSON:", err)
		return
	}

	// bookmarkディレクトリの存在確認
	dirPath = filepath.Join(homeDir, "bookmark")
	if _, err := os.Stat(dirPath); !os.IsNotExist(err) {
		if err := os.RemoveAll(dirPath); err != nil {
			fmt.Println("Error removing dir:", err)
		}
	}

	// bookmarkディレクトリ作成
	if err := os.Mkdir(dirPath, 0755); err != nil {
		fmt.Println("Error creating dir:", err)
	}

	// ブックマークをNameごとにファイルに保存
	j, ok := jsonData.(map[string]interface{})
	if !ok {
		fmt.Println("Error jsonData type assertion:", err)
		return
	}
	roots, ok := j["roots"]
	if !ok {
		fmt.Println("Error roots type assertion:", err)
		return
	}
	r := roots.(map[string]interface{})
	for _, folderData := range r {
		extractUrls(folderData)
	}

	fmt.Println("===== Done format bookmark json =====")
	end := time.Now()
	total := end.Sub(start)
	fmt.Println("total:", total)
}

func extractUrls(folderData interface{}) {
	f := folderData.(map[string]interface{})
	children, ok := f["children"]
	if !ok {
		fmt.Println("Error children type assertion:")
		return
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
			fmt.Println("Error creating bookmark file:", err)
		}
	}
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
