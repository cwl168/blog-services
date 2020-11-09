package limiter

import (
	"time"

	"github.com/gin-gonic/gin"
	"github.com/juju/ratelimit"
)

//接口限流控制 令牌桶实现
type LimiterIface interface {
	Key(c *gin.Context) string                          //获取对应的限流器的键值对名称。
	GetBucket(key string) (*ratelimit.Bucket, bool)     //获取令牌桶。
	AddBuckets(rules ...LimiterBucketRule) LimiterIface //新增多个令牌桶
}

type Limiter struct {
	limiterBuckets map[string]*ratelimit.Bucket
}

type LimiterBucketRule struct {
	Key          string
	FillInterval time.Duration
	Capacity     int64
	Quantum      int64
}
