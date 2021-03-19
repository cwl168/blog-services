package common

//公共分页返回信息
type Pager struct {
	// 页码
	Page int `json:"page"`
	// 每页数量
	PageSize int `json:"page_size"`
	// 总行数
	TotalPage int `json:"total_page"`
	// 总行数
	TotalRows int `json:"total_rows"`
}
