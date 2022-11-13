package system

import (
	"fmt"
	"log"
	"os/exec"
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

func Uptime() (int64, int64) {
	uptime_second, _ := host.Uptime()
	now := time.Now().UnixMilli()
	uptime := now - int64(uptime_second*1000)

	return int64(uptime_second), uptime
}

func SetUptime() {
	log.Printf("Uptime")
	// uptime seconds
	_, uptime := Uptime()
	log.Printf("Uptime / system_uptime: %d", uptime)

	connection := etcd.Connection()
	ctx, cancel := context.WithTimeout(context.Background(), time.Second*1)
	_, err := connection.Put(ctx, "system_uptime", fmt.Sprintf("%d", uptime))
	cancel()
	if err != nil {
		panic("throw error, when put system_uptime")
	}
}

func CodeServerConnection() (string, int64) {
	client := resty.New()
	resp, err := client.R().EnableTrace().SetHeader("Content-Type", "application/json").Get("http://localhost:8080/healthz")
	if err != nil {
		panic(err)
	}
	body := resp.Body()
	// fmt.Printf("%s\n", string())

	status := gojsonq.New().FromString(string(body)).Find("status").(string)
	lastHeartbeat := int64(gojsonq.New().FromString(string(body)).Find("lastHeartbeat").(float64))

	return status, lastHeartbeat
}

func SetCodeServerConnection() {
	log.Printf("CodeServerConnection")
	// check code-server connection
	status, lastHeartbeat := CodeServerConnection()
	log.Printf("CodeServerConnection / status: %s, lastHeartbeat: %d\n", status, lastHeartbeat)

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

func ShutDown() {
	log.Printf("ShutDown")
	shutdown_coomand := exec.Command("sh", "-c", "sudo shutdown -h now")

	now := time.Now().UnixMilli()

	uptime_second, uptime := Uptime()
	log.Printf("ShutDown / system_uptime: %d", uptime)
	log.Printf("ShutDown / uptime_second: %d", uptime_second)

	if uptime_second < 60*10 {
		return
	}

	if uptime_second > 60*60*24 {
		shutdown_coomand.Run()
		return
	}

	// TODO.
	// 람다에서 설정된 예약 종료 확인 code

	_, lastHeartbeat := CodeServerConnection()
	log.Printf("now - lastHeartbeat: %d", (now-lastHeartbeat)/1000)
	if (now-lastHeartbeat)/1000 > 60*10 {
		shutdown_coomand.Run()
	}
}
