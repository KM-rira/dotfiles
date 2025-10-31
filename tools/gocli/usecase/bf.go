package usecase

import (
	"log"
	"strings"

	"github.com/spf13/pflag"
)

func (u *GocmdUsecase) Bf(args []string) error {
	var aFlag bool
	fs := pflag.NewFlagSet("bf", pflag.ContinueOnError)
	fs.BoolVarP(&aFlag, "all", "a", false, "output all files including hidden files")
	if err := fs.Parse(args); err != nil {
		if err == pflag.ErrHelp {
			return nil
		}
		return err
	}

	var files []string
	var err error
	if aFlag { // Bool型はポインタなのでデリファレンス（*）が必要
		files, err = u.gocliService.ListAllFiles()
		if err != nil {
			return err
		}
	} else {
		files, err = u.gocliService.ListVisibleFiles()
		if err != nil {
			return err
		}
	}

	fzfInput := strings.Join(files, "\n") // fzfは改行区切りで候補を認識
	selected, err := u.gocliService.FzfSelectOne(strings.NewReader(fzfInput))
	if err != nil {
		log.Fatal(err)
	}
	if err := u.gocliService.Bat(selected); err != nil {
		log.Fatalf("failed to open bat: %v", err)
	}
	return nil
}
