package system

import (
	"fmt"
	"log"
	"time"

	"github.com/shirou/gopsutil/host"
) 

func Uptime() {
	now := time.Now()
	log.Println(now)
	
	uptime, _ := host.Uptime()
	days := uptime / (60 * 60 * 24)
	hours := (uptime - (days * 60 * 60 * 24)) / (60 * 60)
	minutes := ((uptime - (days * 60 * 60 * 24))  -  (hours * 60 * 60)) / 60
	// log.Println(minutes)
	fmt.Printf("%d days, %d hours, %d minutes",days,hours,minutes) 
}