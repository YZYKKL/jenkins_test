# 使用 Ubuntu 22.04 作为基础镜像
FROM ubuntu:22.04

# 切换为 root 用户
USER root

# 设置环境变量，避免交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装必要工具和依赖（openjdk 11、wget、curl、ca-certificates、gnupg 等）
RUN apt-get update && apt-get install -y \
    openjdk-11-jdk \
    wget \
    curl \
    gnupg \
    ca-certificates \
    git \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# 安装 Jenkins 官方仓库并安装 Jenkins
RUN curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null \
    && echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" \
       | tee /etc/apt/sources.list.d/jenkins.list > /dev/null \
    && apt-get update \
    && apt-get install -y jenkins \
    && rm -rf /var/lib/apt/lists/*

# 设置 Go 版本
ENV GO_VERSION 1.21.1

# 下载并安装 Go
RUN wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz \
    && tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz \
    && rm go${GO_VERSION}.linux-amd64.tar.gz

# 设置 Go 环境变量
ENV PATH="/usr/local/go/bin:${PATH}"

# Jenkins 默认运行端口
EXPOSE 8080

# 设置 Jenkins home 目录权限（默认是 /var/lib/jenkins）
RUN mkdir -p /var/lib/jenkins && chown -R 1000:1000 /var/lib/jenkins

# 切换到 jenkins 用户运行
USER jenkins

# 启动 Jenkins
CMD ["java", "-jar", "/usr/share/jenkins/jenkins.war"]
