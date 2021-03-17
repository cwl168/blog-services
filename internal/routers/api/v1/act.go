package v1

import "github.com/gin-gonic/gin"

type Act struct{}

func NewAct() Act {
	return Act{}
}
func (act Act) TaskList(c *gin.Context) {

}
func (act Act) ReceiveList(c *gin.Context) {

}
