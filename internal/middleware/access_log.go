package middleware

import (
	"bytes"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/go-programming-tour-book/blog-service/global"
	"github.com/go-programming-tour-book/blog-service/pkg/logger"
)

/**
type ResponseWriter interface {
	Header() Header
	Write([]byte) (int, error)
	WriteHeader(statusCode int)
}
*/
type AccessLogWriter struct {
	gin.ResponseWriter
	body *bytes.Buffer
}

//AccessLogWriter 实现了   ResponseWriter
//覆盖了gin.responseWriter的Write方法
func (w AccessLogWriter) Write(p []byte) (int, error) {
	//先写到 buffer,再调用gin.ResponseWriter.Write方法
	if n, err := w.body.Write(p); err != nil {
		return n, err
	}
	return w.ResponseWriter.Write(p)
}

func AccessLog() gin.HandlerFunc {
	return func(c *gin.Context) {
		bodyWriter := &AccessLogWriter{body: bytes.NewBufferString(""), ResponseWriter: c.Writer}
		c.Writer = bodyWriter

		beginTime := time.Now().Unix()
		c.Next()
		endTime := time.Now().Unix()

		fields := logger.Fields{
			"request":  c.Request.Form,
			"response": bodyWriter.body.String(),
		}
		s := "access log: method: %s, status_code: %d, " +
			"begin_time: %d, end_time: %d"
		//Infof方法参数 ctx context.Context 中 ctx为context.Context类型，而c为*gin.Context，为啥能传？  实际上context.Context 是一个接口，而gin.Context也对应实现接口里面方法，在go中，认为事相等的
		global.Logger.WithFields(fields).Infof(c, s,
			c.Request.Method,
			bodyWriter.Status(),
			beginTime,
			endTime,
		)
	}
}
