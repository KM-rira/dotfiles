package main

import (
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

	output.SwitchCommand(cmd, args)
}
