package usecase

import (
	"bytes"
	"fmt"
	"gocli/errorCode"
	"gocli/service"
	"log"
	"strings"
)

type GocmdUsecase struct {
	gocliService *service.GocmdService
}

func NewGocmdUsecase(s *service.GocmdService) *GocmdUsecase {
	return &GocmdUsecase{gocliService: s}
}

func (u *GocmdUsecase) Fd(args []string) error {
	out, err := u.gocliService.Fd(args)
	if err != nil {
		return err
	}
	fmt.Println(string(out))
	return nil
}

func (u *GocmdUsecase) Fdv(args []string) error {
	if len(args) < 3 {
		return fmt.Errorf("%s\n args length: %d", errorCode.NeedParameter, len(args))
	}

	fdOut, err := u.gocliService.Fd(args)
	if err != nil {
		return err
	}
	fzfInput := bytes.NewReader(fdOut)
	selected, err := u.gocliService.FzfSelectOne(fzfInput)
	if err != nil {
		log.Fatal(err)
	}
	if err := u.gocliService.Nvim(selected); err != nil {
		log.Fatalf("failed to open nvim: %v", err)
	}
	return nil
}

func (u *GocmdUsecase) Fdb(args []string) error {
	if len(args) < 3 {
		return fmt.Errorf("%s\n args length: %d", errorCode.NeedParameter, len(args))
	}

	fdOut, err := u.gocliService.Fd(args)
	if err != nil {
		return err
	}
	fzfInput := bytes.NewReader(fdOut)
	selected, err := u.gocliService.FzfSelectOne(fzfInput)
	if err != nil {
		log.Fatal(err)
	}
	if err := u.gocliService.Bat(selected); err != nil {
		log.Fatalf("failed to open bat: %v", err)
	}
	return nil
}

func (u *GocmdUsecase) Showf(args []string) error {
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

func (u *GocmdUsecase) RunDefault() error {
	u.gocliService.HandleDefault()
	return nil
}

// func (u *GocmdUsecase) Rgv(args []string) {
// 	rgOut := u.gocliService.Rg(args)
//
// 	selected, err := u.gocliService.FzfSelectOne(rgOut)
// 	if err != nil {
// 		log.Fatal(err)
// 	}
// 	ext := strings.TrimPrefix(filepath.Ext(selected), ".")
//
// 	paramWord := args[0]
// 	rgNumOut := u.gocliService.RgGetRowNum(paramWord, selected)
//
// 	fzfSelect, err := u.gocliService.FzfSelectRow(rgNumOut, ext)
// 	if err := u.gocliService.NvimSelectRow(selected); err != nil {
// 		log.Fatalf("failed to fzf: %v", err)
// 	}
//
// 	cutWord := u.gocliService.Cut(fzfSelect, ":", 1)
// 	if err := u.gocliService.NvimSelectRow(cutWord, rgNumOut); err != nil {
// 		log.Fatalf("failed to open nvim: %v", err)
// 	}
// }
