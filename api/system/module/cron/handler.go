package cron

import (
	"log"

	"github.com/robfig/cron/v3"

	systemHandler "code-server/controller/cron/system"
)

// go func() {
// 	gocron.Every(5).Seconds().Do(prOk)
// 	<-gocron.Start()
// }()

func setting() *cron.Cron {
	c := cron.New()
	// c.AddFunc("* * * * *", func() { fmt.Println("every 1 min")})
	c.AddFunc("* * * * *", systemHandler.Uptime)
	c.AddFunc("* * * * *", systemHandler.CodeServerConnection)
	return c
}

func Run() {
	log.Println("cron start")
	c := setting()
	c.Start()
}
