package usecase

import (
	"bytes"
	"fmt"
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

func (u *GocmdUsecase) Fd(args []string) {
	out := u.gocliService.Fd(args)
	fmt.Println(string(out))
}

func (u *GocmdUsecase) Fdv(args []string) {
	fdOut := u.gocliService.Fd(args)
	fzfInput := bytes.NewReader(fdOut)
	selected, err := u.gocliService.FzfSelectOne(fzfInput)
	if err != nil {
		log.Fatal(err)
	}
	if err := u.gocliService.Nvim(selected); err != nil {
		log.Fatalf("failed to open nvim: %v", err)
	}
}

func (u *GocmdUsecase) Fdb(args []string) {
	fdOut := u.gocliService.Fd(args)
	fzfInput := bytes.NewReader(fdOut)
	selected, err := u.gocliService.FzfSelectOne(fzfInput)
	if err != nil {
		log.Fatal(err)
	}
	if err := u.gocliService.Bat(selected); err != nil {
		log.Fatalf("failed to open bat: %v", err)
	}
}

func (u *GocmdUsecase) Showf(args []string) {
	gitLogOut := u.gocliService.GitLog(args)
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
}

func (u *GocmdUsecase) Bf(args []string) {
	findOut := u.gocliService.FindOneDepth()
	fzfInput := bytes.NewReader(findOut)
	selected, err := u.gocliService.FzfSelectOne(fzfInput)
	if err != nil {
		log.Fatal(err)
	}
	if err := u.gocliService.Bat(selected); err != nil {
		log.Fatalf("failed to open bat: %v", err)
	}
}

func (u *GocmdUsecase) Vf(args []string) {
	files, _ := u.gocliService.GetCurrentFiles()
	fzfInput := strings.Join(files, "\n") // fzfは改行区切りで候補を認識
	selected, err := u.gocliService.FzfSelectOne(strings.NewReader(fzfInput))
	if err != nil {
		log.Fatal(err)
	}
	if err := u.gocliService.Nvim(selected); err != nil {
		log.Fatalf("failed to open bat: %v", err)
	}
}

func (u *GocmdUsecase) RunDefault() {
	u.gocliService.HandleDefault()
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
