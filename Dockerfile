FROM ubuntu:14.04

RUN sed 's/main$/main universe/' -i /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y

# Download and install wkhtmltopdf
RUN apt-get install -y build-essential xorg libssl-dev libxrender-dev wget gdebi
#RUN wget http://downloads.sourceforge.net/project/wkhtmltopdf/0.12.2.1/wkhtmltox-0.12.2.1_linux-trusty-amd64.deb
RUN wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.2.1/wkhtmltox-0.12.2.1_linux-trusty-amd64.deb
RUN gdebi --n wkhtmltox-0.12.2.1_linux-trusty-amd64.deb

RUN wget https://storage.googleapis.com/golang/go1.11.2.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go1.11.2.linux-amd64.tar.gz
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
    
ENV GO111MODULE=on GOPROXY=https://goproxy.io
