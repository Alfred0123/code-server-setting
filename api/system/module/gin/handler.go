package gin

import (
	"log"

	"github.com/gin-gonic/gin"

	sampleHandler "code-server/controller/http/sample"
	systemHandler "code-server/controller/http/system"
)

func setting() *gin.Engine {
	r := gin.Default()
	r.Use(ErrorHandler())
	// r.Use(ErrorHandler(), gin.Recovery())

	system := r.Group("/system")
	system.GET("/status", systemHandler.Status)
	
	sample := r.Group("/sample")
	sample.GET("/error", sampleHandler.Status)
	return r
}

func Run() {
	log.Println("server start")
	r := setting()
	r.Run()
}