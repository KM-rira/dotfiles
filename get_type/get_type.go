package main

import (
	"flag"
	"fmt"
)

func main() {
	var inputType string
	var selectType string
	flag.StringVar(&inputType, "t", "", "set the type")
	flag.Parse()
	switch inputType {
	case "o":
		selectType = "--state open"
	case "c":
		selectType = "--state closed"
	case "a":
		selectType = "--state all"
	case "d":
		selectType = "--draft"
	default:
		selectType = ""
	}

	fmt.Println(selectType)
}
