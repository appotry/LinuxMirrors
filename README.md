# LinuxMirrors
- __GNU/Linux 更换国内更新源脚本__
- __本项目旨在为从事计算机相关行业的朋友们提供便利__
- __目前已支持绝大部分架构的环境，`x86_64` 与 `arm64` 架构已经过测试__

## 已适配的 GNU/Linux 发行版
|             | Ubuntu |  Debian  |  Kali  |  Fedora  |  CentOS  |
| :------:    | :-----------: | :-----------: | :-----------: | :-----------: | :-----------: |
| 支持版本     | 14.04 ~ 20.10 | 8.0 ~ 10.8 | 2.0 ~ 2021.1 | 28 ~ 33 | 7.0 ~ 8.3 |
> 目前仅支持 Debian 与 Redhat 发行版和及其衍生发行版

***

## 本项目所使用的开源镜像站
| | 镜像站名称 | 镜像站地址 | IPv4 | IPv6 |
| :------: | :------: | :------: | :------: | :------: |
| 1 | 阿里云 | [mirrors.aliyun.com](https://developer.aliyun.com/special/mirrors/notice) | √ | √ |
| 2 | 腾讯云 | [mirrors.cloud.tencent.com](https://mirrors.cloud.tencent.com) | √ | √ |
| 3 | 华为云 | [mirrors.huaweicloud.com](https://mirrors.huaweicloud.com) | √ | √ |
| 4 | 网易 | [mirrors.163.com](https://mirrors.163.com) |  |  |
| 5 | 搜狐 | [mirrors.sohu.com](https://mirrors.sohu.com) |  |  |
| 6 | 清华大学 | [mirrors.tuna.tsinghua.edu.cn](https://mirrors.tuna.tsinghua.edu.cn) | √ | √ |
| 7 | 浙江大学 | [mirrors.zju.edu.cn](https://mirrors.zju.edu.cn) |  |  |
| 8 | 重庆大学 | [mirrors.cqu.edu.cn](https://mirrors.cqu.edu.cn) | √ |  |
| 9 | 兰州大学 | [mirror.lzu.edu.cn](https://mirror.lzu.edu.cn) | √ | √ |
| 10 | 上海交通大学 | [ftp.sjtu.edu.cn](https://ftp.sjtu.edu.cn) | √ | √ |
| 11 | 中国科学技术大学 | [mirrors.ustc.edu.cn](https://mirrors.ustc.edu.cn) | √ | √ |
> 如果使用过程中脚本乱码可对照此列表使用，顺序与脚本一致，数据正在完善中...

***

## 一键执行脚本

- `GNU/Linux` 一键更换国内更新源脚本

      sudo bash <(curl -sSL https://gitee.com/SuperManito/LinuxMirrors/raw/main/ChangeMirrors.sh)
> _友情提示：脚本自带备份功能，无需手动备份原有官方源，如果检测到本地已有备份文件则会跳过备份操作。_

> _注意：`CentOS`和 `Fedora`配置了所有可以配置的仓库，但有一些仓库默认没有启用，若需启用请将 `repo`文件中的 `enabled=0`修改成 `enabled=1`_

***

- `Docker` 国内一键安装脚本

      sudo bash <(curl -sSL https://gitee.com/SuperManito/LinuxMirrors/raw/main/DockerInstallation.sh)
> _注意：脚本集成安装最新版的 `Docker Engine`与 `Docker Compose` ，可手动选择 `Docker CE`源与 `Docker Hub`镜像加速器 ，后续会加入"手动选择安装版本"功能，此脚本将在未来与此项目分离独立建项。_

***

## 常见问题与帮助
- 如果提示 `Command 'curl' not found` 则说明当前未安装 `curl` 软件包，安装命令如下：

      sudo apt install -y curl  或  sudo yum install -y curl

***

> 项目已设立开源许可证书，传播时需在显著位置标注来源和作者，请尊重本人的知识成果\
> 如需使用建议直接调用脚本，如有意见与建议请提交至 __Issues__，谢谢

***

## <img src="https://g.csdnimg.cn/static/logo/favicon32.ico" width="16" height="16" alt="CSDN LOGO"/> [CSDN 博客](https://blog.csdn.net/u013246692/article/details/113124295)

## 明天会更好
<img src="./icon/thank.jpg" width="250" height="250" alt="微信赞赏码"/><br/>

__如果您觉得这个项目不错的话可以在右上角给颗⭐吗？方便分享给更多的朋友吗？__
