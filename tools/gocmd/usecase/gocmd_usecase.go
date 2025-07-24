package usecase

import "gocmd/service"

type GocmdUsecase struct {
	gocmdService *service.GocmdService
}

func NewGocmdUsecase(s *service.GocmdService) *GocmdUsecase {
	return &GocmdUsecase{gocmdService: s}
}

func (u *GocmdUsecase) RunLog() {
	u.gocmdService.HandleLog()
}

func (u *GocmdUsecase) RunDefault() {
	u.gocmdService.HandleDefault()
}

