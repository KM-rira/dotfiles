package usecase

import (
	"log"
	"strings"
)

func (u *GocmdUsecase) Vf(args []string) error {
	files, err := u.gocliService.ListAllFiles()
	if err != nil {
		return err
	}
	fzfInput := strings.Join(files, "\n") // fzfは改行区切りで候補を認識
	selected, err := u.gocliService.FzfSelectOne(strings.NewReader(fzfInput))
	if err != nil {
		log.Fatal(err)
	}
	if err := u.gocliService.Nvim(selected); err != nil {
		log.Fatalf("failed to open bat: %v", err)
	}
	return nil
}

// func (u *GocmdUsecase) Rgv(args []string) {
// 	rgOut := u.gocliService.Rg(args)
//
// 	selected, err := u.gocliService.FzfSelectOne(rgOut)
// 	if err != nil {
// 		log.Fatal(err)
// 	}
// 	ext := strings.TrimPrefix(filepath.Ext(selected), ".")
//
// 	paramWord := args[0]
// 	rgNumOut := u.gocliService.RgGetRowNum(paramWord, selected)
//
// 	fzfSelect, err := u.gocliService.FzfSelectRow(rgNumOut, ext)
// 	if err := u.gocliService.NvimSelectRow(selected); err != nil {
// 		log.Fatalf("failed to fzf: %v", err)
// 	}
//
// 	cutWord := u.gocliService.Cut(fzfSelect, ":", 1)
// 	if err := u.gocliService.NvimSelectRow(cutWord, rgNumOut); err != nil {
// 		log.Fatalf("failed to open nvim: %v", err)
// 	}
// }
