# LinuxMirrors
- __GNU/Linux 更换国内更新源脚本__
- __本项目旨在为从事计算机相关行业的朋友们提供便利__
- __目前仅支持 `x86_64` 架构的环境，`arm` 架构正在完善中__

## 本项目所使用的开源镜像站
| | 镜像站名称 | 镜像站地址 | 支持协议 |
| :------: | :------: | :------: | :------: |
| 1 | 阿里云 | [mirrors.aliyun.com](https://developer.aliyun.com/special/mirrors/notice) |   |
| 2 | 腾讯云 | [mirrors.cloud.tencent.com](https://mirrors.cloud.tencent.com) |  |
| 3 | 华为云 | [mirrors.huaweicloud.com](https://mirrors.huaweicloud.com) |  |
| 4 | 网易 | [mirrors.163.com](https://mirrors.163.com) |  |
| 5 | 搜狐 | [mirrors.sohu.com](https://mirrors.sohu.com) |  |
| 6 | 清华大学 | [mirrors.tuna.tsinghua.edu.cn](https://mirrors.tuna.tsinghua.edu.cn) |  |
| 7 | 浙江大学 | [mirrors.zju.edu.cn](https://mirrors.zju.edu.cn) |  |
| 8 | 重庆大学 | [mirrors.cqu.edu.cn](https://mirrors.cqu.edu.cn) |  |
| 9 | 兰州大学 | [mirror.lzu.edu.cn](https://mirror.lzu.edu.cn) |  |
| 10 | 上海交通大学 | [ftp.sjtu.edu.cn](https://ftp.sjtu.edu.cn) |  |
| 11 | 中国科学技术大学 | [mirrors.ustc.edu.cn](https://mirrors.ustc.edu.cn) |  |
> 如果脚本中文乱码可对照此列表使用，顺序与脚本一致

***

## 已适配的 `GNU/Linux` 发行版
| 操作系统  |   支持的版本   |
| :------: | :-----------: |
| Ubuntu   | 14.04 ~ 20.10 |
| Debian   | 8.0 ~ 10.8    |
| Fedora   | 28 ~ 33       |
| CentOS   | 7.0 ~ 8.3     |
| Kali     | 2.0 ~ 2021.1  |
> 仅支持 Debian 与 Redhat 发行版和及其衍生发行版

***

## `GNU/Linux` 一键更换国内更新源脚本
    sudo bash <(curl -sSL https://gitee.com/SuperManito/LinuxMirrors/raw/main/ChangeMirror.sh)
> _友情提示：脚本自带备份功能，无需手动备份原有官方源。_

> _注意：`CentOS`和 `Fedora`配置了所有可以配置的仓库，但有一些仓库默认没有启用，若需启用请将 `repo`文件中的 `enabled=0`修改成 `enabled=1`_

***

## `Docker` 国内一键安装脚本
    sudo bash <(curl -sSL https://gitee.com/SuperManito/LinuxMirrors/raw/main/DockerInstallation.sh)
> _注意：脚本集成安装最新版的 `Docker Engine`与 `Docker Compose` ，可手动选择 `Docker CE源`与 `镜像加速器` 。_

***

## 常见问题与帮助
- 如果提示 `Command 'curl' not found` 则说明当前未安装 `curl` 软件包，安装命令如下：

      sudo apt install -y curl  或  sudo yum install -y curl

***

> 项目已设立开源许可证书，所有脚本不得用于商业目的，请尊重本人的知识成果\
> 如需使用请直接调用脚本，不要复制后进行传播，如有意见与建议请提交至 Issues

***

### <img src="https://g.csdnimg.cn/static/logo/favicon32.ico" width="16" height="16" alt="CSDN LOGO"/> [CSDN 博客](https://blog.csdn.net/u013246692/article/details/113124295)

### 明天会更好
<img src="./icon/thank.jpg" width="280" height="280" alt="微信赞赏码"/><br/>

__如果您觉得这个项目不错的话可以在右上角给颗⭐吗？方便分享给更多的朋友吗？__
