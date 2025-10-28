package output

import (
	"gocli/service"
	"gocli/usecase"
)

func SwitchCommand(cmd string, args []string) {

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
