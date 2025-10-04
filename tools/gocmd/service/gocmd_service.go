package service

import (
	"bytes"
	"fmt"
	"log"
	"os"
	"os/exec"
	"strings"
)

type GocmdService struct{}

func NewGocmdService() *GocmdService {
	return &GocmdService{}
}

func (s *GocmdService) Fd(args []string) []byte {
	out, err := exec.Command("fd", args...).Output()
	if err != nil {
		log.Fatal(err)
	}
	return out
}

func (s *GocmdService) Fzf(args []byte) (string, error) {
	// fzfコマンドを準備
	cmd := exec.Command("fzf")
	// fzfの標準入力にfdの出力を渡す
	cmd.Stdin = bytes.NewReader(args)
	// fzfの標準出力をキャプチャするためのバッファ
	var out bytes.Buffer
	cmd.Stdout = &out
	// fzfはインタラクティブなUIを標準エラーに出力するので、
	// 現在のプロセスの標準エラーに接続する
	cmd.Stderr = os.Stderr

	// fzfを実行
	err := cmd.Run()
	if err != nil {
		// fzfで何も選択せずに終了した場合(ESCキーなど)もエラーになる。
		// exit status 1は「何もマッチしなかった」、130は「Ctrl+Cで中断」
		// これらはアプリケーションのエラーではないので、ログに出さずに正常終了する。
		if exitError, ok := err.(*exec.ExitError); ok {
			if exitError.ExitCode() == 1 {
				fmt.Println("=== NO MATCH ===")
				return "", nil
			} else if exitError.ExitCode() == 130 {
				fmt.Println("=== CANCEL ===")
				return "", nil
			}
		}
		return "", err
	}
	return strings.TrimSpace(out.String()), nil
}

func (s *GocmdService) Nvim(args string) error {
	if args == "" {
		return nil
	}
	cmd := exec.Command("nvim", args)
	cmd.Stdin = os.Stdin
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	return cmd.Run()
}

func (s *GocmdService) HandleDefault() {
	fmt.Println("=== NOT MATCH COMMAND===")
}
