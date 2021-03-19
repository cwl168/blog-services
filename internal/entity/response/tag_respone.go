package response

import (
	"github.com/go-programming-tour-book/blog-service/internal/entity/common"
)

type TagListResponse struct {
	List interface{} `json:"list"`
	common.Pager
}
