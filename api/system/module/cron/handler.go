package cron

import (
	"fmt"
	"log"

	"github.com/robfig/cron/v3"
)

// go func() {
// 	gocron.Every(5).Seconds().Do(prOk)
// 	<-gocron.Start()
// }()

func setting() *cron.Cron {
	c := cron.New()
	c.AddFunc("* * * * *", func() { fmt.Println("every 1 min")})
	return c
}

func Run() {
	log.Println("cron start")
	c := setting()
	c.Start()
}