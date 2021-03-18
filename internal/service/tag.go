package service

import (
	"github.com/go-programming-tour-book/blog-service/internal/model"
	"github.com/go-programming-tour-book/blog-service/internal/model/request"
)

func (svc *Service) CountTag(param *request.CountTagRequest) (int, error) {
	return svc.dao.CountTag(param.Name, param.State)
}

func (svc *Service) GetTagList(param *request.TagListRequest) ([]*model.Tag, error) {
	return svc.dao.GetTagList(param.Name, param.State, param.Page, param.PageSize)
}

func (svc *Service) CreateTag(param *request.CreateTagRequest) error {
	return svc.dao.CreateTag(param.Name, param.State, param.CreatedBy)
}

func (svc *Service) UpdateTag(param *request.UpdateTagRequest) error {
	return svc.dao.UpdateTag(param.ID, param.Name, param.State, param.ModifiedBy)
}

func (svc *Service) DeleteTag(param *request.DeleteTagRequest) error {
	return svc.dao.DeleteTag(param.ID)
}
