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

	selected, err := u.gocmdService.FzfSelectOne(fdOut)
	if err != nil {
		log.Fatal(err)
	}
	if err := u.gocmdService.Nvim(selected); err != nil {
		log.Fatalf("failed to open nvim: %v", err)
	}
}

func (u *GocmdUsecase) RunBf(args []string) {
	findOut := u.gocmdService.FindOneDepth()

	selected, err := u.gocmdService.FzfSelectOne(findOut)
	if err != nil {
		log.Fatal(err)
	}
	if err := u.gocmdService.Bat(selected); err != nil {
		log.Fatalf("failed to open bat: %v", err)
	}
}

// #!/bin/bash
// bf() {
//     select_file=$(find . -maxdepth 1 -type f | fzf --tac --no-sort --reverse --prompt='Select FILE: ' --no-multi)
//
//     if [ -z "$select_file" ] ; then
//         echo "===== EXIT PROCESS ====="
//         return
//     fi
//
//     # 選択されたコマンドを実行
//     bat $select_file
// }

func (u *GocmdUsecase) RunDefault() {
	u.gocmdService.HandleDefault()
}
