package usecase

import (
	"fmt"
	"gocmd/service"
	"log"
)

type GocmdUsecase struct {
	gocmdService *service.GocmdService
}

func NewGocmdUsecase(s *service.GocmdService) *GocmdUsecase {
	return &GocmdUsecase{gocmdService: s}
}

func (u *GocmdUsecase) Fd(args []string) {
	out := u.gocmdService.Fd(args)
	fmt.Println(string(out))
}

func (u *GocmdUsecase) Fdv(args []string) {
	fdOut := u.gocmdService.Fd(args)

	selected, err := u.gocmdService.FzfSelectOne(fdOut)
	if err != nil {
		log.Fatal(err)
	}
	if err := u.gocmdService.Nvim(selected); err != nil {
		log.Fatalf("failed to open nvim: %v", err)
	}
}

// func (u *GocmdUsecase) Rgv(args []string) {
// 	rgOut := u.gocmdService.Rg(args)
//
// 	selected, err := u.gocmdService.FzfSelectOne(rgOut)
// 	if err != nil {
// 		log.Fatal(err)
// 	}
// 	ext := strings.TrimPrefix(filepath.Ext(selected), ".")
//
// 	paramWord := args[0]
// 	rgNumOut := u.gocmdService.RgGetRowNum(paramWord, selected)
//
// 	fzfSelect, err := u.gocmdService.FzfSelectRow(rgNumOut, ext)
// 	if err := u.gocmdService.NvimSelectRow(selected); err != nil {
// 		log.Fatalf("failed to fzf: %v", err)
// 	}
//
// 	cutWord := u.gocmdService.Cut(fzfSelect, ":", 1)
// 	if err := u.gocmdService.NvimSelectRow(cutWord, rgNumOut); err != nil {
// 		log.Fatalf("failed to open nvim: %v", err)
// 	}
// }

func (u *GocmdUsecase) Bf(args []string) {
	findOut := u.gocmdService.FindOneDepth()

	selected, err := u.gocmdService.FzfSelectOne(findOut)
	if err != nil {
		log.Fatal(err)
	}
	if err := u.gocmdService.Bat(selected); err != nil {
		log.Fatalf("failed to open bat: %v", err)
	}
}

func (u *GocmdUsecase) Vf(args []string) {
	findOut := u.gocmdService.FindOneDepth()

	selected, err := u.gocmdService.FzfSelectOne(findOut)
	if err != nil {
		log.Fatal(err)
	}
	if err := u.gocmdService.Nvim(selected); err != nil {
		log.Fatalf("failed to open bat: %v", err)
	}
}

func (u *GocmdUsecase) RunDefault() {
	u.gocmdService.HandleDefault()
}
