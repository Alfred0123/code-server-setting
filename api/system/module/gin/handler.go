package gin

import (
	"fmt"
	"log"

	"github.com/gin-gonic/gin"

	config "code-server/configs"
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
	// 이렇게 테스트 가능 https://code-server.nanafa.net/proxy/8888/sample/error
	sample.GET("/error", sampleHandler.Status)
	return r
}

func Run() {
	log.Println("server start")
	r := setting()
	r.Run(fmt.Sprintf(":%d", config.RuntimeConf.PORT))
}
