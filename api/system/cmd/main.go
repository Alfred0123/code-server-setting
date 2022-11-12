package main

import (
	"log"
	"net/http"

	"github.com/gin-gonic/gin"

	config "code-server/configs"
)

func init() {
	config.SetEnv()
	log.Printf("ENV: %s", config.RuntimeConf.ENV)
}

func main() {	
	log.Printf("system api start")

	r := gin.Default()
	r.GET("/ping", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{
			"message": "pong",
		})
	})
	r.Run()
}
