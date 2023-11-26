package main

import (
	"flag"
	"fmt"
)

func main() {
	var limit int
	flag.IntVar(&limit, "l", 30, "set the limit")
	flag.Parse()

	fmt.Println(limit)
}
