package response

import (
	"github.com/go-programming-tour-book/blog-service/internal/model/common"
)

type TagListResponse struct {
	List interface{} `json:"list"`
	common.Pager
}
