package main

import (
	"fmt"
	"log"
	"os"
	"os/exec"

	expect "github.com/Netflix/go-expect"
)

func main() {
	c, err := expect.NewConsole(expect.WithStdout(os.Stdout))
	if err != nil {
		log.Fatal(err)
	}
	defer c.Close()
	cmd := exec.Command("docker run -it --rm golang /bin/sh -c 'git --version'")
	cmd.Stdin = c.Tty()
	cmd.Stdout = c.Tty()
	cmd.Stderr = c.Tty()

	fmt.Printf("%v", cmd)
	go func() {
		c.ExpectEOF()
	}()

	err = cmd.Start()
	if err != nil {
		log.Fatal(err)
	}
}
