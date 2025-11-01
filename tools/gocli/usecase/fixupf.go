package usecase

import (
	"bytes"
	"fmt"
	"log"
	"strings"
)

func (u *GocmdUsecase) Fixupf(args []string) error {
	b, err := u.gocliService.ListStagedFiles()
	if err != nil {
		return err
	}
	if len(b) == 0 {
		log.Println("ステージされたファイルがありません。")
		return fmt.Errorf("ステージされたファイルがありません。")
	}
	gitLogOut, err := u.gocliService.GitLog(args)
	if err != nil {
		return err
	}
	fzfInput := bytes.NewReader(gitLogOut)
	selected, err := u.gocliService.FzfSelectOne(fzfInput)
	if err != nil {
		log.Fatal(err)
	}
	fields := strings.Fields(selected)
	commitID := fields[0]
	var commitMessage string
	if len(fields) > 1 {
		commitMessage = strings.Join(fields[1:], " ")
	}
	_ = commitMessage // いまは未使用だが保持

	u.gocliService.GitShow(commitID)
	return nil
}
