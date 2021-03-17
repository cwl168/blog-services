package service

import (
	"github.com/go-programming-tour-book/blog-service/internal/model"
)

type AuthRequest struct {
	AppKey    string `form:"app_key" binding:"required"`
	AppSecret string `form:"app_secret" binding:"required"`
}

func (svc *Service) CheckAuth(param *AuthRequest) (model.Auth, error) {
	auth, err := svc.dao.GetAuth(
		param.AppKey,
		param.AppSecret,
	)

	return auth, err
}
