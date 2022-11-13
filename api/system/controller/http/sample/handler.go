package sample

import (
	"code-server/domain/errors"
	"context"
	"log"
	"time"

	"github.com/gin-gonic/gin"

	etcd "code-server/module/etcd"
)

type TestEndpintQuery struct {
	Sample1 string `form:"sample1" binding:"required"`
}

func Status (c *gin.Context) {
	query := &TestEndpintQuery{}

	err := c.ShouldBindQuery(query)
	if err != nil {
		e := errors.NewError(errors.BAD_REQUEST.Code, errors.BAD_REQUEST.Name, nil)
		c.Error(e)
		return
	}

	connection := etcd.Connection()
	ctx, cancel := context.WithTimeout(context.Background(), time.Second * 1)
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