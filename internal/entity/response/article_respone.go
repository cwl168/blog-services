package response

import (
	"github.com/go-programming-tour-book/blog-service/internal/entity/common"
	"github.com/go-programming-tour-book/blog-service/internal/model"
)

//返回数据结构
type Article struct {
	ID            uint32     `json:"id"`
	Title         string     `json:"title"`
	Desc          string     `json:"desc"`
	Content       string     `json:"content"`
	CoverImageUrl string     `json:"cover_image_url"`
	State         uint8      `json:"state"`
	Tag           *model.Tag `json:"tag"`
}

type ArticleListResponse struct {
	List interface{} `json:"list"`
	common.Pager
}
