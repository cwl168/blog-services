package app

import (
	"net/http"
	"strings"

	"github.com/gin-gonic/gin"
	"github.com/go-programming-tour-book/blog-service/pkg/errcode"
)

type Response struct {
	Ctx *gin.Context
}

type ResponseResult struct {
	Code int         `json:"code"`
	Data interface{} `json:"data"`
	Msg  string      `json:"msg"`
}

func Result(code int, data interface{}, msg string, c *gin.Context) {
	// 开始时间
	c.JSON(http.StatusOK, ResponseResult{
		code,
		data,
		msg,
	})
}

func NewResponse(ctx *gin.Context) *Response {
	return &Response{
		Ctx: ctx,
	}
}

//成功response
func (r *Response) ToResponse(data interface{}) {
	Result(http.StatusOK, data, "操作成功", r.Ctx)
}

//错误response
func (r *Response) ToErrorResponse(err *errcode.Error) {
	Result(err.Code(), nil, strings.Join(err.Details(), ","), r.Ctx)
}
