package service

import (
	"bytes"
	"errors"
	"fmt"
	"gocli/errorCode"
	"io"
	"log"
	"os"
	"os/exec"
	"strconv"
	"strings"
)

type GocmdService struct{}

func NewGocmdService() *GocmdService {
	return &GocmdService{}
}

func (s *GocmdService) Fd(args []string) ([]byte, error) {
	out, err := exec.Command("fd", args...).Output()
	if err != nil {
		log.Fatal(err)
	}
	return out, nil
}

func (s *GocmdService) Rg(args []string) ([]byte, error) {
	out, err := exec.Command("rg -l", args...).Output()
	if err != nil {
		log.Fatal(err)
	}
	return out, nil
}

func (s *GocmdService) RgGetRowNum(paramWord, selectFile string) ([]byte, error) {
	out, err := exec.Command("rg -n", paramWord, selectFile).Output()
	if err != nil {
		log.Fatal(err)
	}
	return out, nil
}

func (s *GocmdService) Cut(input, separateWord string, getField int) (string, error) {
	// 区切りで分割
	parts := strings.Split(input, separateWord)

	// インデックス範囲チェック（cutは1始まり）
	if getField <= 0 || getField > len(parts) {
		return "", nil
	}

	// 該当フィールドを返す
	return parts[getField-1], nil
}

func (s *GocmdService) FzfSelectRow(args []byte, ext string) (string, error) {
	//ROW_NUM=$(rg -n $1 $SELECT_FILE | fzf --tac --no-sort --reverse --prompt='SELECT ROW: ' --no-multi --preview "$HOME/dotfiles/tools/rgv_preview.sh {} ${SELECT_FILE} ; bat --color=always $HOME/.tmp/tmp.${EXT}" | cut -d ':' -f 1)
	// fzfコマンドを準備
	cmd := exec.Command(
		"bash", "-c",
		fmt.Sprintf(
			"fzf --tac --no-sort --reverse --prompt='SELECT ROW: ' --no-multi "+
				"--preview \"$HOME/dotfiles/tools/rgv_preview.sh {} ${SELECT_FILE} ; "+
				"bat --color=always $HOME/.tmp/tmp.%s\"",
			ext,
		),
	)
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
				fmt.Println(errorCode.NotMatch)
				return "", nil
			} else if exitError.ExitCode() == 130 {
				fmt.Println(errorCode.NotMatch)
				return "", nil
			}
		}
		return "", err
	}
	return strings.TrimSpace(out.String()), nil
}

func (s *GocmdService) FindOneDepth() ([]byte, error) {
	// fzfコマンドを準備
	out, err := exec.Command(
		"find", ".", "-maxdepth", "1", "-type", "f",
	).Output()
	if err != nil {
		log.Fatal(err)
	}
	return out, nil
}

func (s *GocmdService) GetCurrentFiles() ([]string, error) {
	dir, err := os.Getwd()
	if err != nil {
		return nil, fmt.Errorf("getwd error: %w", err)
	}

	entries, err := os.ReadDir(dir)
	if err != nil {
		return nil, fmt.Errorf("readdir error: %w", err)
	}

	var files []string
	for _, entry := range entries {
		if !entry.IsDir() {
			files = append(files, entry.Name())
		}
	}

	return files, nil
}

func (s *GocmdService) FzfSelectOne(args io.Reader) (string, error) {
	// fzfコマンドを準備
	cmd := exec.Command(
		"fzf",
		"--tac",
		"--no-sort",
		"--reverse",
		"--prompt=Select FILE: ",
		"--no-multi",
		"--height", "70%",
		"--layout", "reverse",
		"--info", "inline",
		"--border",
		"--preview", "bat --color=always {}",
		"--preview-window", "~3",
		"--bind", "ctrl-/:change-preview-window(50%|hidden|)",
	)
	// fzfの標準入力にfdの出力を渡す
	cmd.Stdin = args
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
				fmt.Println(errorCode.NotMatch)
				return "", nil
			} else if exitError.ExitCode() == 130 {
				fmt.Println(errorCode.Cancel)
				return "", nil
			}
		}
		return "", err
	}
	return strings.TrimSpace(out.String()), nil
}

func (s *GocmdService) NvimSelectRow(selectFile string, rowNum int) error {
	cmd := exec.Command("nvim", selectFile, "+"+strconv.Itoa(rowNum))
	cmd.Stdin = os.Stdin
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	return cmd.Run()
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

func (s *GocmdService) Bat(args string) error {
	if args == "" {
		return nil
	}
	cmd := exec.Command("bat", args)
	cmd.Stdin = os.Stdin
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	return cmd.Run()
}

func (s *GocmdService) HandleDefault() error {
	return errors.New(errorCode.NotMatchCommand)
}

func (s *GocmdService) GitLog(args []string) ([]byte, error) {
	gitLog := exec.Command("git", "log", "--oneline", "-n", "50")
	var logOut bytes.Buffer
	gitLog.Stdout = &logOut
	gitLog.Stderr = os.Stderr
	if err := gitLog.Run(); err != nil {
		log.Fatalf("git log の実行に失敗: %v", err)
	}
	return logOut.Bytes(), nil
}

func (s *GocmdService) GitShow(commitID string) error {
	show := exec.Command("git", "show", commitID)
	show.Stdout = os.Stdout
	show.Stderr = os.Stderr
	if err := show.Run(); err != nil {
		log.Fatalf("git show の実行に失敗: %v", err)
	}
	return nil
}
