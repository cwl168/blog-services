FROM golang:alpine
RUN apk add build-base
# 为我们的镜像设置必要的环境变量
#支持平台 ，那么我们就要进行交叉编译，而交叉编译不支持 cgo，因此这里要禁用掉它  关闭 cgo 后，在构建过程中会忽略 cgo 并静态链接所有的依赖库，而开启 cgo 后，方式将转为动态链接
ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

# 移动到工作目录：/build
WORKDIR /build

# 将代码复制到容器中
COPY . .
RUN go env -w GO111MODULE=on
RUN go env -w GOPROXY=https://goproxy.cn,direct

# 将我们的代码编译成二进制可执行文件blog-service
RUN go build -o blog-service .

# 移动到用于存放生成的二进制文件的 /dist 目录
WORKDIR /dist

# 将二进制文件从 /build 目录复制到这里 -r 目录拷贝
RUN cp -r /build/configs /dist
RUN cp /build/blog-service .

# 声明服务端口
EXPOSE 8888

# 启动容器时运行的命令
CMD ["/dist/blog-service"]