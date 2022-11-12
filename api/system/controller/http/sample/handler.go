package sample

import (
	"code-server/domain/errors"

	"github.com/gin-gonic/gin"
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

	c.JSON(200, gin.H{
		"message": "success",
	})
}