package output

import (
	"gocli/service"
	"gocli/usecase"
)

func SwitchCommand(cmd string, args []string) error {

	var err error
	gocliService := service.NewGocmdService()
	gocliUsecase := usecase.NewGocmdUsecase(gocliService)
    switch cmd {
    case "bf":
        err = gocliUsecase.Bf(args)
    case "vf":
        err = gocliUsecase.Vf(args)
    case "showf":
        err = gocliUsecase.Showf(args)
    case "fixupf":
        err = gocliUsecase.Fixupf(args)
    default:
		err = gocliUsecase.RunDefault()
	}
	return err
}
