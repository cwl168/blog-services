package service

import (
	"context"

	otgorm "github.com/eddycjy/opentracing-gorm"

	"github.com/go-programming-tour-book/blog-service/global"
	"github.com/go-programming-tour-book/blog-service/internal/dao"
)

type Service struct {
	ctx context.Context
	dao *dao.Dao
}

func New(ctx context.Context) Service {
	svc := Service{ctx: ctx}
	//svc.dao = dao.New(global.DBEngine)
	svc.dao = dao.New(otgorm.WithContext(svc.ctx, global.DBEngine)) //每一次请求都需要将上下文注册进来,otgorm.WithContext(svc.ctx, global.DBEngine)这么写，为了实现sql追踪
	return svc
}
