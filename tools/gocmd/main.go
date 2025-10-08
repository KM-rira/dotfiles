package main

import (
	"gocmd/service"
	"gocmd/usecase"
	"os"
)

func main() {
	var cmd string
	var args []string

	if len(os.Args) > 1 {
		cmd = os.Args[1]
	}

	if len(os.Args) > 2 {
		args = os.Args[2:]
	}

	gocmdService := service.NewGocmdService()
	gocmdUsecase := usecase.NewGocmdUsecase(gocmdService)

	switch cmd {
	case "fd":
		gocmdUsecase.RunFd(args)
	case "fdv":
		gocmdUsecase.RunFdv(args)
	case "bf":
		gocmdUsecase.RunBf(args)
	default:
		gocmdUsecase.RunDefault()
	}
}
