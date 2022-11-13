package main

import (
	"log"

	// "github.com/gin-gonic/gin"

	config "code-server/configs"
	cron "code-server/module/cron"
	etcd "code-server/module/etcd"
	gin "code-server/module/gin"
)

func init() {
	config.SetEnv()
	log.Printf("ENV: %s", config.RuntimeConf.ENV)
	etcd.Run()
}

func main() {	
	log.Printf("system api start")

	cron.Run()
	gin.Run()
}
