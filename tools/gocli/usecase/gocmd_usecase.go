package usecase

import (
	"fmt"
	"gocli/service"
	"log"
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

	selected, err := u.gocliService.FzfSelectOne(fdOut)
	if err != nil {
		log.Fatal(err)
	}
	if err := u.gocliService.Nvim(selected); err != nil {
		log.Fatalf("failed to open nvim: %v", err)
	}
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

func (u *GocmdUsecase) Bf(args []string) {
	findOut := u.gocliService.FindOneDepth()

	selected, err := u.gocliService.FzfSelectOne(findOut)
	if err != nil {
		log.Fatal(err)
	}
	if err := u.gocliService.Bat(selected); err != nil {
		log.Fatalf("failed to open bat: %v", err)
	}
}

func (u *GocmdUsecase) Vf(args []string) {
	findOut := u.gocliService.FindOneDepth()

	selected, err := u.gocliService.FzfSelectOne(findOut)
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
