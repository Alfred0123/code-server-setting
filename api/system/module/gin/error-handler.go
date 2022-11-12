package gin

import (
	"code-server/domain/errors"
	"fmt"
	"log"

	"github.com/gin-gonic/gin"
)

// TODO. 이부분 middleware 로 따로 빼기
func ErrorHandler() gin.HandlerFunc {
	return func(c *gin.Context) {
		c.Next()
		// error 는 여러개 쌓여있을수 있다.
		for _, e := range c.Errors {
			err := e.Err
			log.Printf("err: %s", err)
			if serverError, ok := err.(*errors.ServerError); ok {
				// log.Printf("err: %s", err)
				// log.Printf("myErr")
				fmt.Printf("%+v", serverError.Err)
				c.JSON(serverError.Code, gin.H{
					"msg": serverError.Msg,
					"data": serverError.Data,
					"meta": serverError.Err.Error(),
				})
			} else {
				log.Printf("not myErr")
				c.JSON(500, gin.H{
					"msg": "Server exception",
					"data": e.Error(),
					// "meta": e.,
				})
			}
			return
		}
	}

	// return func (c *gin.Context) {
	// 	c.Next()
	// 	err := c.Errors.Last()
		
	// 	if err == nil {
	// 			return
	// 	}
		
	// 	if serverError, ok := err.Err.(*errors.ServerError); ok {
	// 		log.Printf(serverError.Error())
	// 	}
	// }
}