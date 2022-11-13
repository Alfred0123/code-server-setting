package system

import (
	"fmt"
	"log"
	"time"

	"github.com/shirou/gopsutil/host"

	etcd "code-server/module/etcd"
	"context"

	"github.com/go-resty/resty/v2"
	"github.com/thedevsaddam/gojsonq/v2"
)

// func Uptime() {
// 	now := time.Now()
// 	log.Println(now)

// 	uptime, _ := host.Uptime()
// 	days := uptime / (60 * 60 * 24)
// 	hours := (uptime - (days * 60 * 60 * 24)) / (60 * 60)
// 	minutes := ((uptime - (days * 60 * 60 * 24)) - (hours * 60 * 60)) / 60
// 	// log.Println(minutes)
// 	fmt.Printf("%d days, %d hours, %d minutes", days, hours, minutes)
// }

func Uptime() {
	// uptime seconds
	seconds, _ := host.Uptime()
	log.Printf("system_uptime_seconds: %d", seconds)

	now := time.Now().UnixMilli()
	uptime := now - int64(seconds*1000)
	log.Printf("system_uptime: %d", uptime)

	connection := etcd.Connection()
	ctx, cancel := context.WithTimeout(context.Background(), time.Second*1)
	_, err := connection.Put(ctx, "system_uptime", fmt.Sprintf("%d", uptime))
	cancel()
	if err != nil {
		panic("throw error, when put system_uptime")
	}
}

func CodeServerConnection() {
	// check code-server connection
	client := resty.New()
	resp, err := client.R().EnableTrace().SetHeader("Content-Type", "application/json").Get("http://localhost:8080/healthz")
	if err != nil {
		panic(err)
	}
	body := resp.Body()
	// fmt.Printf("%s\n", string())

	status := gojsonq.New().FromString(string(body)).Find("status")
	lastHeartbeat := int64(gojsonq.New().FromString(string(body)).Find("lastHeartbeat").(float64))
	fmt.Printf("status: %s, lastHeartbeat: %d\n", status, lastHeartbeat)

	if status != "alive" {
		return
	}
	// code_server_last_connect_time
	connection := etcd.Connection()
	ctx, cancel := context.WithTimeout(context.Background(), time.Second*1)
	_, etcd_err := connection.Put(ctx, "code_server_last_connect_time", fmt.Sprintf("%d", lastHeartbeat))
	cancel()
	if etcd_err != nil {
		panic("throw error, when put system_uptime")
	}
}
