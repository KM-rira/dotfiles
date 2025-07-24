package service

import "fmt"

type GocmdService struct{}

func NewGocmdService() *GocmdService {
	return &GocmdService{}
}

func (s *GocmdService) HandleLog() {
	fmt.Println("log")
}

func (s *GocmdService) HandleDefault() {
	fmt.Println("=== NOT MATCH COMMAND===")
}

