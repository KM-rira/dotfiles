package service

import (
	"fmt"
	"log"
	"os/exec"
)

type GocmdService struct{}

func NewGocmdService() *GocmdService {
	return &GocmdService{}
}

func (s *GocmdService) Fd(args []string) []byte {
	out, err := exec.Command("fd", args...).Output()
	if err != nil {
		log.Fatal(err)
	}
	return out
}

func (s *GocmdService) HandleDefault() {
	fmt.Println("=== NOT MATCH COMMAND===")
}

