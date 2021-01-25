#!/bin/bash
#Author:SuperManito
SYSTEM=`cat /etc/redhat-release`
SYSTEM_NAME=`cat /etc/redhat-release | cut -c1-6`
SYSTEM_VERSION_CENTOS=`cat /etc/redhat-release | cut -c22`
echo -e '\033[37m##################################################### \033[0m'
echo -e ''
echo -e '\033[37m           提供以下六种国内更新源可供选择： \033[0m'
echo -e ''
echo -e '\033[37m##################################################### \033[0m'
echo -e ''
echo -e '\033[37m*    1) 中科大 \033[0m'
echo -e ''
echo -e '\033[37m*    2) 华为云 \033[0m'
echo -e ''
echo -e '\033[37m*    3) 阿里云 \033[0m'
echo -e ''
echo -e '\033[37m*    4) 网易 \033[0m'
echo -e ''
echo -e '\033[37m*    5) 清华大学 \033[0m'
echo -e ''
echo -e '\033[37m*    6) 浙江大学 \033[0m'
echo -e ''
echo -e '\033[37m##################################################### \033[0m'
echo -e ''
echo -e "\033[37m           当前操作系统  $SYSTEM \033[0m"
echo -e "\033[37m           当前系统时间  `date +%Y-%m-%d` `date +%H:%M` \033[0m"
echo -e ''
echo -e '\033[37m##################################################### \033[0m'
echo -e ''
CHOICE=`echo -e '\033[32m请输入你想使用的国内更新源[1~6]： \033[0m'`
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
  SOURCE="mirrors.tuna.tsinghua.edu.cn"
  ;;
6)
  SOURCE="mirrors.zju.edu.cn"
  ;;
*)
  SOURCE="mirrors.ustc.edu.cn"
  echo -e ''
  echo -e '\033[33m----------输入错误，更新源将默认使用中科大源---------- \033[0m'
  sleep 3s
  ;;
esac
ls /etc | grep yum.repos.d.bak -qw
if [ $? -eq 0 ];then
  echo -e '\033[32m检测到已备份的 repo源 文件，跳过备份操作...... \033[0m'
else
  mkdir -p /etc/yum.repos.d.bak
  cp -rf /etc/yum.repos.d/* /etc/yum.repos.d.bak
  echo -e '\033[32m已备份原有 repo源 文件至 /etc/yum.repos.d.bak ...... \033[0m'
fi
sleep 2s
rm -rf /etc/yum.repos.d/*
if [ $SYSTEM_VERSION_CENTOS = "8" ];then
touch /etc/yum.repos.d/CentOS-Linux-AppStream.repo
touch /etc/yum.repos.d/CentOS-Linux-BaseOS.repo
touch /etc/yum.repos.d/CentOS-Linux-Extras.repo
touch /etc/yum.repos.d/CentOS-Linux-PowerTools.repo
touch /etc/yum.repos.d/CentOS-Linux-Plus.repo
cat >/etc/yum.repos.d/CentOS-Linux-AppStream.repo <<\EOF
[appstream]
name=CentOS Linux $releasever - AppStream
baseurl=http://mirror.centos.org/centos/$releasever/AppStream/$basearch/os/
gpgcheck=1
enabled=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
EOF
cat >/etc/yum.repos.d/CentOS-Linux-BaseOS.repo <<\EOF
[baseos]
name=CentOS Linux $releasever - BaseOS
baseurl=http://mirror.centos.org/centos/$releasever/BaseOS/$basearch/os/
gpgcheck=1
enabled=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
EOF
cat >/etc/yum.repos.d/CentOS-Linux-Extras.repo <<\EOF
[extras]
name=CentOS Linux $releasever - Extras
baseurl=http://mirror.centos.org/centos/$releasever/extras/$basearch/os/
gpgcheck=1
enabled=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
EOF
cat >/etc/yum.repos.d/CentOS-Linux-PowerTools.repo <<\EOF
[powertools]
name=CentOS Linux $releasever - PowerTools
baseurl=http://mirror.centos.org/centos/$releasever/PowerTools/$basearch/os/
gpgcheck=1
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
EOF
cat >/etc/yum.repos.d/CentOS-Linux-Plus.repo <<\EOF
[plus]
name=CentOS Linux $releasever - Plus
baseurl=http://mirror.centos.org/centos/$releasever/centosplus/$basearch/os/
gpgcheck=1
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
EOF
sed -i "s|http://mirror.centos.org|https://$SOURCE|g" \
/etc/yum.repos.d/CentOS-Linux-AppStream.repo \
/etc/yum.repos.d/CentOS-Linux-BaseOS.repo \
/etc/yum.repos.d/CentOS-Linux-Extras.repo \
/etc/yum.repos.d/CentOS-Linux-PowerTools.repo \
/etc/yum.repos.d/CentOS-Linux-Plus.repo
elif [ $SYSTEM_VERSION_CENTOS = "7" ];then
touch /etc/yum.repos.d/CentOS-BaseOS.repo
cat >/etc/yum.repos.d/CentOS-BaseOS.repo <<\EOF
[base]
name=CentOS-$releasever - Base
baseurl=http://mirror.centos.org/centos/$releasever/os/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
[updates]
name=CentOS-$releasever - Updates
baseurl=http://mirror.centos.org/centos/$releasever/updates/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
[extras]
name=CentOS-$releasever - Extras
baseurl=http://mirror.centos.org/centos/$releasever/extras/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
[centosplus]
name=CentOS-$releasever - Plus
baseurl=http://mirror.centos.org/centos/$releasever/centosplus/$basearch/
gpgcheck=1
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
EOF
sed -i "s|http://mirror.centos.org|https://$SOURCE|g" /etc/yum.repos.d/CentOS-BaseOS.repo
elif [ $SYSTEM_NAME = "Fedora" ];then
touch /etc/yum.repos.d/fedora.repo
touch /etc/yum.repos.d/fedora-updates.repo
touch /etc/yum.repos.d/fedora-modular.repo
touch /etc/yum.repos.d/fedora-updates-modular.repo
cat >/etc/yum.repos.d/fedora.repo <<\EOF
[fedora]
name=Fedora $releasever - $basearch
baseurl=http://download.example/pub/fedora/linux/releases/$releasever/Everything/$basearch/os/
enabled=1
countme=1
metadata_expire=7d
repo_gpgcheck=0
type=rpm
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=False
[fedora-debuginfo]
name=Fedora $releasever - $basearch - Debug
baseurl=http://download.example/pub/fedora/linux/releases/$releasever/Everything/$basearch/debug/tree/
enabled=0
metadata_expire=7d
repo_gpgcheck=0
type=rpm
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=False
[fedora-source]
name=Fedora $releasever - Source
baseurl=http://download.example/pub/fedora/linux/releases/$releasever/Everything/source/tree/
enabled=0
metadata_expire=7d
repo_gpgcheck=0
type=rpm
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=False
EOF
cat >/etc/yum.repos.d/fedora-updates.repo <<\EOF
[updates]
name=Fedora $releasever - $basearch - Updates
baseurl=http://download.example/pub/fedora/linux/updates/$releasever/Everything/$basearch/
enabled=1
countme=1
repo_gpgcheck=0
type=rpm
gpgcheck=1
metadata_expire=6h
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=False
[updates-debuginfo]
name=Fedora $releasever - $basearch - Updates - Debug
baseurl=http://download.example/pub/fedora/linux/updates/$releasever/Everything/$basearch/debug/
enabled=0
repo_gpgcheck=0
type=rpm
gpgcheck=1
metadata_expire=6h
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=False
[updates-source]
name=Fedora $releasever - Updates Source
baseurl=http://download.example/pub/fedora/linux/updates/$releasever/Everything/SRPMS/
enabled=0
repo_gpgcheck=0
type=rpm
gpgcheck=1
metadata_expire=6h
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=False
EOF
cat >/etc/yum.repos.d/fedora-modular.repo <<\EOF
[fedora-modular]
name=Fedora Modular $releasever - $basearch
baseurl=http://download.example/pub/fedora/linux/releases/$releasever/Modular/$basearch/os/
enabled=1
countme=1
#metadata_expire=7d
repo_gpgcheck=0
type=rpm
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=False
[fedora-modular-debuginfo]
name=Fedora Modular $releasever - $basearch - Debug
baseurl=http://download.example/pub/fedora/linux/releases/$releasever/Modular/$basearch/debug/tree/
enabled=0
metadata_expire=7d
repo_gpgcheck=0
type=rpm
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=False
[fedora-modular-source]
name=Fedora Modular $releasever - Source
baseurl=http://download.example/pub/fedora/linux/releases/$releasever/Modular/source/tree/
enabled=0
metadata_expire=7d
repo_gpgcheck=0
type=rpm
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=False
EOF
cat >/etc/yum.repos.d/fedora-updates-modular.repo <<\EOF
[updates-modular]
name=Fedora Modular $releasever - $basearch - Updates
baseurl=http://download.example/pub/fedora/linux/updates/$releasever/Modular/$basearch/
enabled=1
countme=1
repo_gpgcheck=0
type=rpm
gpgcheck=1
metadata_expire=6h
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=False
[updates-modular-debuginfo]
name=Fedora Modular $releasever - $basearch - Updates - Debug
baseurl=http://download.example/pub/fedora/linux/updates/$releasever/Modular/$basearch/debug/
enabled=0
repo_gpgcheck=0
type=rpm
gpgcheck=1
metadata_expire=6h
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=False
[updates-modular-source]
name=Fedora Modular $releasever - Updates Source
baseurl=http://download.example/pub/fedora/linux/updates/$releasever/Modular/SRPMS/
enabled=0
repo_gpgcheck=0
type=rpm
gpgcheck=1
metadata_expire=6h
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=False
EOF
cat >/etc/yum.repos.d/fedora-updates-testing.repo <<\EOF
[updates-testing]
name=Fedora $releasever - $basearch - Test Updates
baseurl=http://download.example/pub/fedora/linux/updates/testing/$releasever/Everything/$basearch/
enabled=0
countme=1
repo_gpgcheck=0
type=rpm
gpgcheck=1
metadata_expire=6h
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=False
[updates-testing-debuginfo]
name=Fedora $releasever - $basearch - Test Updates Debug
baseurl=http://download.example/pub/fedora/linux/updates/testing/$releasever/Everything/$basearch/debug/
enabled=0
repo_gpgcheck=0
type=rpm
gpgcheck=1
metadata_expire=6h
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=False
[updates-testing-source]
name=Fedora $releasever - Test Updates Source
baseurl=http://download.example/pub/fedora/linux/updates/testing/$releasever/Everything/SRPMS/
enabled=0
repo_gpgcheck=0
type=rpm
gpgcheck=1
metadata_expire=6h
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=False
EOF
cat >/etc/yum.repos.d/fedora-updates-testing-modular.repo <<\EOF
[updates-testing-modular]
name=Fedora Modular $releasever - $basearch - Test Updates
baseurl=http://download.example/pub/fedora/linux/updates/testing/$releasever/Modular/$basearch/
enabled=0
countme=1
repo_gpgcheck=0
type=rpm
gpgcheck=1
metadata_expire=6h
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=False
[updates-testing-modular-debuginfo]
name=Fedora Modular $releasever - $basearch - Test Updates Debug
baseurl=http://download.example/pub/fedora/linux/updates/$releasever/Modular/$basearch/debug/
enabled=0
repo_gpgcheck=0
type=rpm
gpgcheck=1
metadata_expire=6h
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=False
[updates-testing-modular-source]
name=Fedora Modular $releasever - Test Updates Source
baseurl=http://download.example/pub/fedora/linux/updates/$releasever/Modular/SRPMS/
enabled=0
repo_gpgcheck=0
type=rpm
gpgcheck=1
metadata_expire=6h
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=False
EOF
sed -i "s|http://download.example/pub/fedora/linux|https://$SOURCE/fedora|g" \
/etc/yum.repos.d/fedora.repo \
/etc/yum.repos.d/fedora-updates.repo \
/etc/yum.repos.d/fedora-modular.repo \
/etc/yum.repos.d/fedora-updates-modular.repo \
/etc/yum.repos.d/fedora-updates-testing.repo \
/etc/yum.repos.d/fedora-updates-testing-modular.repo
fi
yum makecache
