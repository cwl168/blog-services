FROM golang:alpine AS builder

# 为我们的镜像设置必要的环境变量
ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

# 移动到工作目录：/build
WORKDIR /build
RUN go env -w GO111MODULE=on
RUN go env -w GOPROXY=https://goproxy.cn,https://mirrors.aliyun.com/goproxy/,direct
# 复制项目中的 go.mod 和 go.sum文件并下载依赖信息
COPY go.mod .
COPY go.sum .
RUN go mod download

# 将代码复制到容器中
COPY . .


# 将我们的代码编译成二进制可执行文件 blog-service
RUN go build -o blog-service .

###################
# 接下来创建一个小镜像
###################
#FROM scratch
#apt-get需要
FROM debian:stretch-slim

COPY ./configs /configs
COPY ./wait-for-it.sh /
COPY ./init.sh /

# 从builder镜像中把/dist/app 拷贝到当前目录
COPY --from=builder /build/blog-service /

RUN set -eux; \
	apt-get update; \
	apt-get install -y \
		--no-install-recommends \
		netcat; \
        chmod 755 wait-for-it.sh

RUN chmod +x /init.sh

# 需要运行的命令 docker run --name blog -it -p 8888:8888 blog-service ，用到 wait-for-it 容器启动顺序，需要将/blog-service运行注释
#ENTRYPOINT ["/init.sh"]