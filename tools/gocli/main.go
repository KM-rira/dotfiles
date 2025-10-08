package main

import (
	"gocli/service"
	"gocli/usecase"
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

	gocliService := service.NewGocmdService()
	gocliUsecase := usecase.NewGocmdUsecase(gocliService)

	switch cmd {
	case "fd":
		gocliUsecase.Fd(args)
	case "fdv":
		gocliUsecase.Fdv(args)
	case "bf":
		gocliUsecase.Bf(args)
	case "vf":
		gocliUsecase.Vf(args)
	// case "rgv":
	// 	gocliUsecase.Rgv(args)
	default:
		gocliUsecase.RunDefault()
	}
}
