#!/bin/env bash
## Author:SuperManito

## 定义变量：
## 判定系统是基于 Debian 还是 RedHat
ls /etc | grep redhat-release -qw
if [ $? -eq 0 ]; then
    SYSTEM="RedHat"
else
    SYSTEM="Debian"
fi
## 系统判定变量（系统名称、系统版本、系统版本号）
if [ $SYSTEM = "Debian" ]; then
    SYSTEM_NAME=$(lsb_release -is)
    SYSTEM_VERSION=$(lsb_release -cs)
    SYSTEM_VERSION_NUMBER=$(lsb_release -rs)
elif [ $SYSTEM = "RedHat" ]; then
    SYSTEM_NAME=$(cat /etc/redhat-release | cut -c1-6)
    if [ $SYSTEM_NAME = "CentOS" ]; then
        SYSTEM_VERSION_NUMBER=$(cat /etc/redhat-release | cut -c22-24)
        CENTOS_VERSION=$(cat /etc/redhat-release | cut -c22)
    elif [ $SYSTEM_NAME = "Fedora" ]; then
        SYSTEM_VERSION_NUMBER=$(cat /etc/redhat-release | cut -c16-18)
    fi
fi

## 环境搭建：
function Installation() {
    if [ $SYSTEM_NAME = "Ubuntu" ]; then
        apt remove -y docker docker-engine docker.io containerd runc
        apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
        add-apt-repository -y "deb [arch=amd64] https://mirrors.ustc.edu.cn/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
        apt update
        apt install -y docker-ce docker-ce-cli containerd.io
    elif [ $SYSTEM_NAME = "Debian" ]; then
        apt remove -y docker docker-engine docker.io containerd runc
        apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
        curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
        add-apt-repository -y "deb [arch=amd64] https://mirrors.ustc.edu.cn/docker-ce/linux/debian $(lsb_release -cs) stable"
        apt update
        apt install -y docker-ce docker-ce-cli containerd.io
    elif [ $SYSTEM_NAME = "Kali" ]; then
        apt remove -y docker docker-engine docker.io containerd runc
        apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
        curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
        add-apt-repository -y "deb [arch=amd64] https://mirrors.ustc.edu.cn/docker-ce/linux/debian $(lsb_release -cs) stable"
        apt update
        apt install -y docker-ce docker-ce-cli containerd.io
    elif [ $SYSTEM_NAME = "CentOS" ]; then
        yum remove -y docker* runc
        yum install -y yum-utils device-mapper-persistent-data lvm2
        yum-config-manager -y --add-repo https://mirrors.ustc.edu.cn/docker-ce/linux/centos/docker-ce.repo
        yum makecache
        yum install -y docker-ce docker-ce-cli containerd.io
    elif [ $SYSTEM_NAME = "Fedora" ]; then
        yum remove -y docker* runc
        yum -y install yum-utils device-mapper-persistent-data lvm2
        yum config-manager -y --add-repo https://mirrors.ustc.edu.cn/docker-ce/linux/fedora/docker-ce.repo
        yum makecache
        yum install -y docker-ce docker-ce-cli containerd.io
    fi
    ## 创建目录和文件
    mkdir -p /etc/docker
    touch /etc/docker/daemon.json
    ## 配置阿里云镜像加速器
    echo '{"registry-mirrors": ["https://registry.cn-hangzhou.aliyuncs.com"]}' >/etc/docker/daemon.json
    ## 启动 Docker 进程
    systemctl enable --now docker
}
Installation
