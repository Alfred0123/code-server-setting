package system

import (
	"log"
	"time"
) 

func Uptime() {
	now := time.Now()
	log.Println(now)
}