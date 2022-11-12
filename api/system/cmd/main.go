package main

import (
	"log"

	// "github.com/gin-gonic/gin"

	config "code-server/configs"
	gin "code-server/module/gin"
)

func init() {
	config.SetEnv()
	log.Printf("ENV: %s", config.RuntimeConf.ENV)
}

func main() {	
	log.Printf("system api start")

	gin.Run()
}
