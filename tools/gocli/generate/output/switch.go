package output

import (
	"fmt"
	"gocli/service"
	"gocli/usecase"
)

func SwitchCommand(cmd string, args []string) {
	fmt.Println("hello!!")

	gocliService := service.NewGocmdService()
	gocliUsecase := usecase.NewGocmdUsecase(gocliService)
	switch cmd {
	case "bf":
		gocliUsecase.Bf(args)
	case "vf":
		gocliUsecase.Vf(args)
	case "showf":
		gocliUsecase.Showf(args)
	default:
		gocliUsecase.RunDefault()
	}
}
