FROM ubuntu:14.04

RUN sed 's/main$/main universe/' -i /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y

# Download and install wkhtmltopdf
RUN apt-get install -y build-essential xorg libssl-dev libxrender-dev wget gdebi
#RUN wget http://downloads.sourceforge.net/project/wkhtmltopdf/0.12.2.1/wkhtmltox-0.12.2.1_linux-trusty-amd64.deb
RUN wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.2.1/wkhtmltox-0.12.2.1_linux-trusty-amd64.deb
RUN gdebi --n wkhtmltox-0.12.2.1_linux-trusty-amd64.deb

RUN wget https://storage.googleapis.com/golang/go1.8.4.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go1.8.4.linux-amd64.tar.gz
RUN export PATH=$PATH:/usr/local/go/bin 

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN apt-get install -y git

# Timezone
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# Chinese fonts
RUN wget http://www.mycode.net.cn/wp-content/uploads/2015/07/YaHeiConsolas.tar.gz
RUN tar -zxvf YaHeiConsolas.tar.gz && cp ./YaHeiConsolas.ttf /usr/share/fonts/truetype/dejavu \
    && chmod 644 /usr/share/fonts/truetype/dejavu/YaHeiConsolas.ttf

# 安装微框架
RUN go get github.com/aliyun/aliyun-log-go-sdk
RUN go get github.com/asaskevich/govalidator
RUN go get github.com/sirupsen/logrus
RUN go get github.com/rs/xid
RUN go get golang.org/x/net/context
RUN go get google.golang.org/grpc
RUN go get github.com/joho/godotenv
RUN mkdir -p /go/src/github.com/chrisho/mosquito && \
    git clone -b k8s https://github.com/chrisho/mosquito.git /go/src/github.com/chrisho/mosquito

# Download go package
RUN go get github.com/samuel/go-zookeeper/zk
RUN go get github.com/sirupsen/logrus
RUN go get github.com/go-redis/redis
RUN go get github.com/jinzhu/gorm
RUN go get golang.org/x/crypto/bcrypt
RUN go get github.com/go-sql-driver/mysql
RUN go get github.com/asaskevich/govalidator
RUN go get github.com/garyburd/redigo/redis
RUN go get github.com/gin-gonic/gin
RUN go get github.com/rainbowism/osin
RUN go get github.com/rainbowism/osin-redis
RUN go get github.com/tommy351/gin-csrf
RUN go get github.com/tommy351/gin-sessions
RUN go get github.com/google/uuid
RUN go get github.com/SebastiaanKlippert/go-wkhtmltopdf
RUN go get github.com/xuri/excelize
RUN go get github.com/aliyun/aliyun-oss-go-sdk/oss
RUN go get github.com/chrisho/sd-grpc-paginate
