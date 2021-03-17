package routers

import (
	"github.com/go-programming-tour-book/blog-service/configs"
	"github.com/go-programming-tour-book/blog-service/pkg/app"
	"net/http"
	"time"

	"github.com/go-programming-tour-book/blog-service/pkg/limiter"

	"github.com/go-programming-tour-book/blog-service/global"

	"github.com/gin-gonic/gin"
	_ "github.com/go-programming-tour-book/blog-service/docs"
	"github.com/go-programming-tour-book/blog-service/internal/middleware"
	"github.com/go-programming-tour-book/blog-service/internal/routers/api"
	"github.com/go-programming-tour-book/blog-service/internal/routers/api/v1"
	ginSwagger "github.com/swaggo/gin-swagger"
	"github.com/swaggo/gin-swagger/swaggerFiles"
)

var methodLimiters = limiter.NewMethodLimiter().AddBuckets(
	limiter.LimiterBucketRule{
		Key:          "/auth", //auth 接口限流一分钟  10次请求
		FillInterval: time.Minute,
		Capacity:     10,
		Quantum:      10,
	},
)

func NewRouter() *gin.Engine {
	r := gin.New()
	if global.ServerSetting.RunMode != "debug" {
		r.Use(gin.Logger())
		r.Use(gin.Recovery()) //gin 异常捕获处理中间件
	} else {
		r.Use(middleware.AccessLog())
		r.Use(middleware.Recovery())
	}

	//注册中间件
	r.Use(middleware.Tracing())                                               //链路追踪
	r.Use(middleware.RateLimiter(methodLimiters))                             //接口限流
	r.Use(middleware.ContextTimeout(global.AppSetting.DefaultContextTimeout)) //超时控制
	r.Use(middleware.Translations())                                          //国际化处理

	article := v1.NewArticle()
	tag := v1.NewTag()
	act := v1.NewAct()
	upload := api.NewUpload()
	r.GET("/debug/vars", api.Expvar)
	r.GET("/swagger/*any", ginSwagger.WrapHandler(swaggerFiles.Handler))
	r.POST("/upload/file", upload.UploadFile)
	r.Any("/auth", api.GetAuth)

	//测试读取配置文件
	r.GET("/config", bindataStaticHandler)
	//访问图片  http://127.0.0.1:8000/static/c4ca4238a0b923820dcc509a6f75849b.png
	r.StaticFS("/static", http.Dir(global.AppSetting.UploadSavePath))
	apiv1 := r.Group("/api/v1")
	apiv1.Use() //middleware.JWT()
	{
		// 创建标签
		apiv1.POST("/tags", tag.Create)
		// 删除指定标签
		apiv1.DELETE("/tags/:id", tag.Delete)
		// 更新指定标签
		apiv1.PUT("/tags/:id", tag.Update)
		// 获取标签列表
		apiv1.GET("/tags", tag.List)

		// 创建文章
		apiv1.POST("/articles", article.Create)
		// 删除指定文章
		apiv1.DELETE("/articles/:id", article.Delete)
		// 更新指定文章
		apiv1.PUT("/articles/:id", article.Update)
		// 获取指定文章
		apiv1.GET("/articles/:id", article.Get)
		// 获取文章列表
		apiv1.GET("/articles", article.List)

		//活动相关接口
		apiv1.GET("/task_list", act.TaskList) //任务列表
		apiv1.GET("/receive_list", act.ReceiveList)

	}

	return r
}

//go-bindata  打包配置文件，读取出来为 base64 格式
func bindataStaticHandler(c *gin.Context) {
	response := app.NewResponse(c)
	data, err := configs.Asset("configs/config.yaml")
	if err != nil {
		global.Logger.Errorf(c, "app.GetConfig errs: %v", err)
	}
	response.ToResponse(gin.H{
		"data": string(data),
	})
}
