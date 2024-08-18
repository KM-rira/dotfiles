package main

import (
	"fmt"
	"os"
	"path/filepath"
)

func main() {
	// コマンドライン引数からディレクトリパスを取得
	if len(os.Args) < 2 {
		fmt.Println("Usage: go run main.go <directory_path>")
		return
	}

	dir := os.Args[1] // ディレクトリと出力ファイルのパスを設定
	outputFile := "$HOME/.tmp/file_list.sh"

	// 環境変数の展開
	dir = os.ExpandEnv(dir)
	outputFile = os.ExpandEnv(outputFile)

	// ディレクトリ内のファイル一覧を取得
	files, err := os.ReadDir(dir)
	if err != nil {
		fmt.Println("Error reading directory:", err)
		return
	}

	// 出力ファイルを作成（既存の内容は上書きされる）
	file, err := os.Create(outputFile)
	if err != nil {
		fmt.Println("Error creating file:", err)
		return
	}
	defer file.Close()

	// `.sh` ファイルをフィルタリングし、結果を書き込む
	for _, f := range files {
		if filepath.Ext(f.Name()) == ".sh" {
			_, err := file.WriteString("source " + dir + "/" + f.Name() + "\n")
			if err != nil {
				fmt.Println("Error writing to file:", err)
				return
			}
		}
	}
}
