package main

import (
	"fmt"
	"log"

	expect "github.com/google/goexpect"
)

func main() {
	e, _, err := expect.Spawn(fmt.Sprintf("docker -v /var/run/docker.sock:/var/run/docker.sock hello-world"), -1)
	if err != nil {
		log.Fatal(err)
	}
	defer e.Close()

}
