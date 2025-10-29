package main

import (
	"fmt"
	"gocli/generate/output"
	"os"
)

func main() {
	var cmd string
	var args []string

	if len(os.Args) > 1 {
		cmd = os.Args[1]
	}

	if len(os.Args) > 2 {
		args = os.Args[2:]
	}

	if err := output.SwitchCommand(cmd, args); err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}

}
