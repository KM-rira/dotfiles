package main

import (
	"github.com/fatih/color"
	"gocli/generate/output"
	"os"
)

func main() {
	var cmd string
	if len(os.Args) > 1 {
		cmd = os.Args[1]
	}

	if err := output.SwitchCommand(cmd, os.Args); err != nil {
		red := color.New(color.FgRed, color.Bold)
		red.Fprintln(os.Stderr, err.Error())
		os.Exit(1)
	}

}
