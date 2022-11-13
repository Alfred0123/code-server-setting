package sample

import (
	"code-server/domain/errors"
	"context"
	"log"
	"os"
	"os/exec"
	"time"

	"github.com/gin-gonic/gin"

	etcd "code-server/module/etcd"
)

type TestEndpintQuery struct {
	Sample1 string `form:"sample1" binding:"required"`
}

func Status(c *gin.Context) {
	query := &TestEndpintQuery{}

	err := c.ShouldBindQuery(query)
	if err != nil {
		e := errors.NewError(errors.BAD_REQUEST.Code, errors.BAD_REQUEST.Name, nil)
		c.Error(e)
		return
	}

	connection := etcd.Connection()
	ctx, cancel := context.WithTimeout(context.Background(), time.Second*1)
	// resp, err := connection.Put(ctx, "foo", "test123")
	resp, err := connection.Get(ctx, "foo")
	cancel()
	if err != nil {
		panic("put error")
	}
	log.Println(resp)
	// connection.Close()

	c.JSON(200, gin.H{
		"message": "success",
	})
}

func ShutDown(c *gin.Context) {
	// cmd := exec.Command("sh", "-c", "ls -al")
	cmd := exec.Command("sh", "-c", "sudo shutdown -h now") // shutdown
	// cmd := exec.Command("sh", "-c", "sudo shutdown -h +1") // 1분후 shutdown
	// cmd := exec.Command("sh", "-c", "sudo shutdown -r") // restart
	cmd.Stdout = os.Stdout
	log.Println(cmd.Run())
	// exec.Command("sudo", "shutdown", "-h", "now")
	// syscall.Shutdown()
	// reboot
	// syscall.Shutdown()
	// syscall.Reboot(syscall.LINUX_REBOOT_CMD_POWER_OFF)
	// syscall.Reboot(syscall.LINUX_REBOOT_CMD_RESTART)
	c.JSON(200, gin.H{
		"message": "success",
	})
	// exec.Command()
	// exec.Command("cmd", "/C", "shutdown")
}
