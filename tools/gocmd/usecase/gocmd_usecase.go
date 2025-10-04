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

func (u *GocmdUsecase) RunFd(args []string) {
	out := u.gocmdService.Fd(args)
	fmt.Println(string(out))
}

func (u *GocmdUsecase) RunFdv(args []string) {
	fdOut := u.gocmdService.Fd(args)

	selected, err := u.gocmdService.Fzf(fdOut)
	if err != nil {
		log.Fatal(err)
	}
	if err := u.gocmdService.Nvim(selected); err != nil {
		log.Fatalf("failed to open nvim: %v", err)
	}
}

func (u *GocmdUsecase) RunDefault() {
	u.gocmdService.HandleDefault()
}
