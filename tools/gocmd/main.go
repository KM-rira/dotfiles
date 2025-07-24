package main

import (
	"gocmd/service"
	"gocmd/usecase"
	"os"
)

func main() {
	var cmd string
	if len(os.Args) > 1 {
		cmd = os.Args[1]
	}

	gocmdService := service.NewGocmdService()
	gocmdUsecase := usecase.NewGocmdUsecase(gocmdService)

	switch cmd {
	case "log":
		gocmdUsecase.RunLog()
	default:
		gocmdUsecase.RunDefault()
	}
}
