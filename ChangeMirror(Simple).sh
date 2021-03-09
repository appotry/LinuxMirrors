#!/bin/env bash
## Author:SuperManito

## 系统判定变量：
## 判定系统是基于 Debian 还是 RedHat
ls /etc | grep redhat-release -qw
if [ $? -eq 0 ]; then
    SYSTEM="RedHat"
else
    SYSTEM="Debian"
fi
## 定义一些变量（系统名称、系统版本、系统版本号）
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

## 更换国内源：
function ChangeMirror() {
  echo -e ''
  echo -e '+---------------------------------------------------+'
  echo -e '|                                                   |'
  echo -e '|   =============================================   |'
  echo -e '|                                                   |'
  echo -e '|         欢迎使用 Linux 一键更换国内源脚本         |'
  echo -e '|                                                   |'
  echo -e '|   =============================================   |'
  echo -e '|                                                   |'
  echo -e '+---------------------------------------------------+'
  echo -e ''
  echo -e '#####################################################'
  echo -e ''
  echo -e '            提供以下国内更新源可供选择：'
  echo -e ''
  echo -e '#####################################################'
  echo -e ' *  1)    中科大'
  echo -e ' *  2)    华为云'
  echo -e ' *  3)    阿里云'
  echo -e ' *  4)    网易'
  echo -e ' *  4)    搜狐'
  echo -e ' *  6)    清华大学'
  echo -e ' *  7)    浙江大学'
  echo -e ' *  8)    南京大学'
  echo -e ' *  9)    重庆大学'
  echo -e ' *  10)   兰州大学'
  echo -e ' *  11)   上海交通大学'
  echo -e ' *  12)   北京交通大学'
  echo -e ' *  13)   北京理工大学'
  echo -e ' *  14)   南京邮电大学'
  echo -e ' *  15)   华中科技大学'
  echo -e ' *  16)   哈尔滨工业大学'
  echo -e ' *  17)   北京外国语大学'
  echo -e ''
  echo -e '#####################################################'
  echo -e ''
  echo -e "      当前操作系统  $SYSTEM_NAME $SYSTEM_VERSION_NUMBER"
  echo -e "      当前系统时间  $(date +%Y-%m-%d) $(date +%H:%M)"
  echo -e ''
  echo -e '#####################################################'
  echo -e ''
  CHOICE=$(echo -e '\033[32m请输入您想使用的国内更新源 [ 1~17 ]：\033[0m')
  read -p "$CHOICE" INPUT
  case $INPUT in
  1)
    SOURCE="mirrors.ustc.edu.cn"
    ;;
  2)
    SOURCE="mirrors.huaweicloud.com"
    ;;
  3)
    SOURCE="mirrors.aliyun.com"
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
    SOURCE="mirrors.nju.edu.cn"
    ;;
  9)
    SOURCE="mirrors.cqu.edu.cn"
    ;;
  10)
    SOURCE="mirror.lzu.edu.cn"
    ;;
  11)
    SOURCE="ftp.sjtu.edu.cn"
    ;;
  12)
    SOURCE="mirror.bjtu.edu.cn"
    ;;
  13)
    SOURCE="mirror.bit.edu.cn"
    ;;
  14)
    SOURCE="mirrors.njupt.edu.cn"
    ;;
  15)
    SOURCE="mirrors.hust.edu.cn"
    ;;
  16)
    SOURCE="mirrors.hit.edu.cn"
    ;;
  17)
    SOURCE="mirrors.bfsu.edu.cn"
    ;;
  *)
    SOURCE="mirrors.ustc.edu.cn"
    echo -e ''
    echo -e '\033[33m----------输入错误，更新源将默认使用中科大源---------- \033[0m'
    sleep 3s
    ;;
  esac

  if [ $SYSTEM = "Debian" ]; then
    DebianMirrors
  elif [ $SYSTEM = "RedHat" ]; then
    RedHatMirrors
  fi
}

## 基Debian系Linux发行版的Source更新源：
function DebianMirrors() {
  ls /etc/apt | grep sources.list.bak -qw
  if [ $? -eq 0 ]; then
    echo -e '\033[32m检测到已备份的 source.list源 文件，跳过备份操作...... \033[0m'
  else
    cp -rf /etc/apt/sources.list /etc/apt/sources.list.bak
    echo -e '\033[32m已备份原有 source.list 更新源文件...... \033[0m'
  fi
  sleep 3s
  sed -i '1,$d' /etc/apt/sources.list
  if [ $SYSTEM_NAME = "Ubuntu" ]; then
    echo "deb https://$SOURCE/ubuntu/ $SYSTEM_VERSION main restricted universe multiverse" >>/etc/apt/sources.list
    echo "deb-src https://$SOURCE/ubuntu/ $SYSTEM_VERSION main restricted universe multiverse" >>/etc/apt/sources.list
    echo "deb https://$SOURCE/ubuntu/ $SYSTEM_VERSION-security main restricted universe multiverse" >>/etc/apt/sources.list
    echo "deb-src https://$SOURCE/ubuntu/ $SYSTEM_VERSION-security main restricted universe multiverse" >>/etc/apt/sources.list
    echo "deb https://$SOURCE/ubuntu/ $SYSTEM_VERSION-updates main restricted universe multiverse" >>/etc/apt/sources.list
    echo "deb-src https://$SOURCE/ubuntu/ $SYSTEM_VERSION-updates main restricted universe multiverse" >>/etc/apt/sources.list
    echo "deb https://$SOURCE/ubuntu/ $SYSTEM_VERSION-proposed main restricted universe multiverse" >>/etc/apt/sources.list
    echo "deb-src https://$SOURCE/ubuntu/ $SYSTEM_VERSION-proposed main restricted universe multiverse" >>/etc/apt/sources.list
    echo "deb https://$SOURCE/ubuntu/ $SYSTEM_VERSION-backports main restricted universe multiverse" >>/etc/apt/sources.list
    echo "deb-src https://$SOURCE/ubuntu/ $SYSTEM_VERSION-backports main restricted universe multiverse" >>/etc/apt/sources.list
  elif [ $SYSTEM_NAME = "Debian" ]; then
    echo "deb https://$SOURCE/debian/ $SYSTEM_VERSION main contrib non-free" >>/etc/apt/sources.list
    echo "deb-src https://$SOURCE/debian/ $SYSTEM_VERSION main contrib non-free" >>/etc/apt/sources.list
    echo "deb https://$SOURCE/debian/ $SYSTEM_VERSION-updates main contrib non-free" >>/etc/apt/sources.list
    echo "deb-src https://$SOURCE/debian/ $SYSTEM_VERSION-updates main contrib non-free" >>/etc/apt/sources.list
    echo "deb https://$SOURCE/debian/ $SYSTEM_VERSION-backports main contrib non-free" >>/etc/apt/sources.list
    echo "deb-src https://$SOURCE/debian/ $SYSTEM_VERSION-backports main contrib non-free" >>/etc/apt/sources.list
    echo "deb https://$SOURCE/debian-security $SYSTEM_VERSION/updates main contrib non-free" >>/etc/apt/sources.list
    echo "deb-src https://$SOURCE/debian-security $SYSTEM_VERSION/updates main contrib non-free" >>/etc/apt/sources.list
  elif [ $SYSTEM_NAME = "Kali" ]; then
    echo "deb https://$SOURCE/kali $SYSTEM_VERSION main non-free contrib" >>/etc/apt/sources.list
    echo "deb-src https://$SOURCE/kali $SYSTEM_VERSION main non-free contrib" >>/etc/apt/sources.list
  fi
  apt update
}

## 基于RedHat系Linux发行版的repo更新源：
function RedHatMirrors() {
  ## 此处调用基于 RedHat 系列 Linux 官方源一键生成脚本
  bash <(curl -sL https://gitee.com/SuperManito/LinuxMirrors/raw/main/RedHat-Official-Mirror-Generation.sh)
  if [ $SYSTEM_NAME = "CentOS" ]; then
    sed -i 's|^mirrorlist=|#mirrorlist=|g' /etc/yum.repos.d/*
    sed -i 's|^#baseurl=http://mirror.centos.org/$contentdir|baseurl=https://mirror.centos.org/centos|g' /etc/yum.repos.d/*
    sed -i 's|^#baseurl=http://mirror.centos.org|baseurl=http://mirror.centos.org|g' /etc/yum.repos.d/*
    sed -i "s|mirror.centos.org|$SOURCE|g" /etc/yum.repos.d/*
    elif [ $SYSTEM_NAME = "Fedora" ]; then
    sed -i 's|^metalink=|#metalink=|g' \
    /etc/yum.repos.d/fedora.repo \
    /etc/yum.repos.d/fedora-updates.repo \
    /etc/yum.repos.d/fedora-modular.repo \
    /etc/yum.repos.d/fedora-updates-modular.repo \
    /etc/yum.repos.d/fedora-updates-testing.repo \
    /etc/yum.repos.d/fedora-updates-testing-modular.repo
    sed -i 's|^#baseurl=|baseurl=|g' /etc/yum.repos.d/*
    sed -i "s|http://download.example/pub/fedora/linux|https://$SOURCE/fedora|g" \
    /etc/yum.repos.d/fedora.repo \
    /etc/yum.repos.d/fedora-updates.repo \
    /etc/yum.repos.d/fedora-modular.repo \
    /etc/yum.repos.d/fedora-updates-modular.repo \
    /etc/yum.repos.d/fedora-updates-testing.repo \
    /etc/yum.repos.d/fedora-updates-testing-modular.repo
  fi
  yum makecache
}

SystemJudgment
ChangeMirror