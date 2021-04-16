#!/bin/env bash
## Author: SuperManito

## 定义目录文件变量：
DebianConfig=/etc/apt/sources.list
DebianConfigBackup=/etc/apt/sources.list.bak
RedHatDirectory=/etc/yum.repos.d
RedHatDirectoryBackup=/etc/yum.repos.d.bak
DockerConfig=/etc/docker/daemon.json
DockerConfigBackup=/etc/docker/daemon.json.bak

## 判定系统是基于 Debian 还是 RedHat
ls /etc | grep redhat-release -qw
if [ $? -eq 0 ]; then
    SYSTEM="RedHat"
else
    SYSTEM="Debian"
fi
## 系统判定变量
## 名称、版本、版本号、使用架构
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

if [ $SYSTEM_NAME = "Ubuntu" ]; then
    SOURCE_BRANCH=ubuntu
elif [ $SYSTEM_NAME = "Debian" ]; then
    SOURCE_BRANCH=debian
elif [ $SYSTEM_NAME = "Kali" ]; then
    SOURCE_BRANCH=debian
elif [ $SYSTEM_NAME = "CentOS" ]; then
    SOURCE_BRANCH=centos
elif [ $SYSTEM_NAME = "Fedora" ]; then
    SOURCE_BRANCH=fedora
fi

Architecture=$(arch)
if [ $Architecture = "x86_64" ]; then
    SYSTEM_ARCH=x86_64
    SOURCE_ARCH=amd64
elif [ $Architecture = "aarch64" ]; then
    SYSTEM_ARCH=arm64
    SOURCE_ARCH=arm64
elif [ $Architecture = "armv*" ]; then
    SYSTEM_ARCH=arm32
    SOURCE_ARCH=armhf
else
    SYSTEM_ARCH=${Architecture}
    SOURCE_ARCH=armhf
fi

## 更换 Docker 国内源：
function ChangeMirrors() {
    clear
    echo -e '+---------------------------------------------------+'
    echo -e '|                                                   |'
    echo -e '|   =============================================   |'
    echo -e '|                                                   |'
    echo -e '|         欢迎使用 Docker 国内一键安装脚本          |'
    echo -e '|                                                   |'
    echo -e '|   =============================================   |'
    echo -e '|                                                   |'
    echo -e '+---------------------------------------------------+'
    echo -e ''
    echo -e '#####################################################'
    echo -e ''
    echo -e '  提供以下国内 Docker CE 和 Docker Hub 源可供选择：'
    echo -e ''
    echo -e '#####################################################'
    echo -e ''
    echo -e ' Docker CE '
    echo -e ''
    echo -e ' *  1)    阿里云'
    echo -e ' *  2)    腾讯云'
    echo -e ' *  3)    华为云'
    echo -e ' *  4)    网易'
    echo -e ' *  4)    搜狐'
    echo -e ' *  6)    清华大学'
    echo -e ' *  7)    浙江大学'
    echo -e ' *  8)    重庆大学'
    echo -e ' *  9)    兰州大学'
    echo -e ' *  10)   上海交通大学'
    echo -e ' *  11)   中国科学技术大学'
    echo -e ''
    echo -e ' Docker Hub（镜像加速器） '
    echo -e ''
    echo -e ' *  1)    阿里云'
    echo -e ' *  2)    腾讯云'
    echo -e ' *  3)    官方中国区'
    echo -e ' *  4)    DaoCloud'
    echo -e ' *  5)    中国科学技术大学'
    echo -e ' *  6)    网易'
    echo -e ''
    echo -e '#####################################################'
    echo -e ''
    echo -e "         运行环境  $SYSTEM_NAME $SYSTEM_VERSION_NUMBER $SYSTEM_ARCH"
    echo -e "         系统时间  $(date "+%Y-%m-%d %H:%M:%S")"
    echo -e ''
    echo -e '#####################################################'
    echo -e ''
    CHOICE_A=$(echo -e '\033[32m└ 请输入您想使用的 Docker CE 源 [ 1~11 ]：\033[0m')
    read -p "$CHOICE_A" INPUT
    case $INPUT in
    1)
        SOURCE="mirrors.aliyun.com"
        ;;
    2)
        SOURCE="mirrors.cloud.tencent.com"
        ;;
    3)
        SOURCE="mirrors.huaweicloud.com"
        ;;
    4)
        SOURCE="mirrors.163.com"
        ;;
    5)
        SOURCE="mirrors.sohu.com"
        ;;
    6)
        SOURCE="mirrors.tuna.tsinghua.edu.cn"
        ;;
    7)
        SOURCE="mirrors.zju.edu.cn"
        ;;
    8)
        SOURCE="mirrors.cqu.edu.cn"
        ;;
    9)
        SOURCE="mirror.lzu.edu.cn"
        ;;
    10)
        SOURCE="ftp.sjtu.edu.cn"
        ;;
    11)
        SOURCE="mirrors.ustc.edu.cn"
        ;;
    *)
        SOURCE="mirrors.aliyun.com"
        echo -e '\n\033[33m---------- 输入错误，更新源将默认使用阿里源 ---------- \033[0m'
        sleep 2s
        ;;
    esac
    echo -e ''

    ## 定义镜像加速器
    CHOICE_B=$(echo -e '\033[32m└ 请输入您想使用的 Docker Hub 源 [ 1~6 ]：\033[0m')
    read -p "$CHOICE_B" INPUT
    case $INPUT in
    1)
        REGISTRYSOURCE="registry.cn-hangzhou.aliyuncs.com"
        ;;
    2)
        REGISTRYSOURCE="mirror.ccs.tencentyun.com"
        ;;
    3)
        REGISTRYSOURCE="registry.docker-cn.com"
        ;;
    4)
        REGISTRYSOURCE="f1361db2.m.daocloud.io"
        ;;
    5)
        REGISTRYSOURCE="docker.mirrors.ustc.edu.cn"
        ;;
    6)
        REGISTRYSOURCE="hub-mirror.c.163.com"
        ;;
    *)
        REGISTRYSOURCE="registry.cn-hangzhou.aliyuncs.com"
        echo -e '\033[33m---------- 输入错误，将默认使用阿里云镜像加速器 ---------- \033[0m'
        sleep 3s
        ;;
    esac
    echo -e ''
}

## 安装 Docker Engine ：
function DockerEngine() {
    ## 定义 Docker CE 国内源
    ChangeMirrors

    ## 卸载旧版本
    if [ $SYSTEM = "Debian" ]; then
        apt-get remove -y docker* containerd runc >/dev/null 2>&1
    elif [ $SYSTEM = "RedHat" ]; then
        yum remove -y docker* >/dev/null 2>&1
    fi

    ## 安装环境软件包
    if [ $SYSTEM = "Debian" ]; then
        apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
    elif [ $SYSTEM = "RedHat" ]; then
        yum install -y yum-utils device-mapper-persistent-data lvm2
    fi

    ## 删除旧的 Docker CE 源
    if [ $SYSTEM = "Debian" ]; then
        sed -i '/docker-ce/d' ${DebianConfig}
    elif [ $SYSTEM = "RedHat" ]; then
        rm -rf ${RedHatDirectory}/docker-ce.repo
    fi

    ## 配置 Docker CE 源
    if [ $SYSTEM = "Debian" ]; then
        curl -fsSL https://download.docker.com/linux/${SOURCE_BRANCH}/gpg | apt-key add -
        add-apt-repository -y "deb [arch=$SOURCE_ARCH] https://$SOURCE/docker-ce/linux/${SOURCE_BRANCH} $SYSTEM_VERSION stable"
    elif [ $SYSTEM = "RedHat" ]; then
        yum-config-manager -y --add-repo https://$SOURCE/docker-ce/linux/${SOURCE_BRANCH}/docker-ce.repo
    fi

    ## 安装 Docker Engine
    if [ $SYSTEM = "Debian" ]; then
        apt-get update
        apt-get install -y docker-ce docker-ce-cli containerd.io
    elif [ $SYSTEM = "RedHat" ]; then
        yum makecache
        yum install -y docker-ce docker-ce-cli containerd.io
    fi

    ## 配置镜像加速器
    ImageAccelerator
}

## 配置镜像加速器：
function ImageAccelerator() {
    ## 创建目录和文件
    ls /etc | grep docker/daemon.json
    if [ $? -eq 0 ]; then
        ls /etc | grep docker/daemon.json.bak
        if [ $? -eq 0 ]; then
            echo -e '\n└ 监测到已备份的 Docker 配置文件，跳过执行备份操作......\n'
            sleep 2s
        else
            mv -f ${DockerConfig} ${DockerConfigBackup}
            echo -e '\n└ 已备份原有 Docker 配置文件......\n'
            sleep 2s
        fi
    else
        mkdir -p /etc/docker >/dev/null 2>&1
        touch ${DockerConfig}
    fi

    ## 配置镜像加速器
    echo -e '{\n  "registry-mirrors": ["https://SOURCE"]\n}' >${DockerConfig}
    sed -i "s/SOURCE/$REGISTRYSOURCE/g" ${DockerConfig}

    ## 启动 Docker Engine
    systemctl stop docker >/dev/null 2>&1
    systemctl enable --now docker
}

## 安装 Docker Compose：
function DockerCompose() {
    CHOICE_C=$(echo -e '\n\033[32m└ 是否安装 Docker Compose [ Y/N ]：\033[0m')
    read -p "$CHOICE_C" INPUT
    case $INPUT in
    [Yy]*)
        curl -L https://get.daocloud.io/docker/compose/releases/download/1.29.0/docker-compose-$(uname -s)-$(uname -m) >/usr/local/bin/docker-compose
        chmod +x /usr/local/bin/docker-compose
        echo -e ''
        ;;
    [Nn]*) ;;
    *)
        echo -e '\033[33m---------- 输入错误，默认不安装 Docker Compose ---------- \033[0m\n'
        ;;
    esac
}

DockerEngine
DockerCompose

## 查看版本信息
docker info
docker compose --version
echo -e ''
