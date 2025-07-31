package usecase

import (
	"fmt"
	"gocmd/service"
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

func (u *GocmdUsecase) RunDefault() {
	u.gocmdService.HandleDefault()
}

