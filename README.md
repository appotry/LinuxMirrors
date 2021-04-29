# LinuxMirrors
<a href="https://github.com/SuperManito/LinuxMirrors"><img src="./icon/github-1.svg" width="34" height="42"></a>
<a href="https://github.com/SuperManito/LinuxMirrors"><img src="./icon/github-2.svg" width="70" height="52"></a>
ㅤ<a href="https://gitee.com/SuperManito/LinuxMirrors"><img src="./icon/gitee.svg" width="100" height="50"/></a>
&nbsp;<a href="https://blog.csdn.net/u013246692/article/details/113124295"><img src="./icon/csdn.png" width="100" height="50"/></a>

- __`GNU/Linux` 一键更换国内软件源脚本__
- __本项目旨在为从事计算机相关行业的朋友们提供便利__
- __理论支持所有架构的环境，`x86_64` 与 `arm64` 架构已经过测试__

### 更新日志
- __2021 / 04 / 24__
ㅤ新增基于 CentOS 的 EPEL 扩展源，修复了一些错误。
- __2021 / 04 / 22__
ㅤ重新定义了备份原有源功能，现在可以通过检测其目录下是否存在源文件判断是否执行备份操作。

***

### 已适配的 GNU/Linux 发行版 <img src="./icon/linux.svg" width="16" height="16" alt="Linux Logo"/>
|          | <a href="https://ubuntu.com"><img src="./icon/ubuntu.svg" width="14" height="14"/></a>&nbsp;Ubuntu |  <a href="https://www.debian.org"><img src="./icon/debian.svg" width="14" height="14"/></a>&nbsp;Debian  |  <a href="https://www.kali.org"><img src="./icon/kali.svg" width="14" height="14"/></a>&nbsp;Kali Linux  |  <a href="https://getfedora.org"><img src="./icon/fedora.svg" width="14" height="14"/></a>&nbsp;Fedora  |  <a href="https://www.centos.org"><img src="./icon/centos.svg" width="16" height="16"/></a>&nbsp;CentOS  |
| :------: | :------: | :------: | :------: | :------: | :------: |
| 支持的版本 | 14.04 ~ 21.04 | 8.0 ~ 10.9 | 2.0 ~ 2021.1 | 28 ~ 34 | 7.0 ~ 8.3 |
> 目前仅支持基于 Debian 与 Redhat 的发行版和及其部分衍生发行版

### 脚本所使用的开源镜像站
| | 镜像站名称 | 镜像站地址 | IPv4 | IPv6 |
| :------: | :------: | :------: | :------: | :------: |
| 1 | 阿里云 | [mirrors.aliyun.com](https://developer.aliyun.com/special/mirrors/notice) | √ | √ |
| 2 | 腾讯云 | [mirrors.cloud.tencent.com](https://mirrors.cloud.tencent.com) | √ | √ |
| 3 | 华为云 | [mirrors.huaweicloud.com](https://mirrors.huaweicloud.com) | √ | √ |
| 4 | 网易 | [mirrors.163.com](https://mirrors.163.com) | √ | × |
| 5 | 搜狐 | [mirrors.sohu.com](https://mirrors.sohu.com) | √ | × |
| 6 | 清华大学 | [mirrors.tuna.tsinghua.edu.cn](https://mirrors.tuna.tsinghua.edu.cn) | √ | √ |
| 7 | 浙江大学 | [mirrors.zju.edu.cn](https://mirrors.zju.edu.cn) | √ | × |
| 8 | 重庆大学 | [mirrors.cqu.edu.cn](https://mirrors.cqu.edu.cn) | √ | × |
| 9 | 兰州大学 | [mirror.lzu.edu.cn](https://mirror.lzu.edu.cn) | √ | √ |
| 10 | 上海交通大学 | [ftp.sjtu.edu.cn](https://ftp.sjtu.edu.cn) | √ | √ |
| 11 | 中国科学技术大学 | [mirrors.ustc.edu.cn](https://mirrors.ustc.edu.cn) | √ | √ |
> 如果使用过程中脚本不能正常输出中文内容则可对照此列表使用，顺序与脚本一致

### 脚本执行流程
- └ 选择国内源（交互）
- └ 执行备份操作
  - └ 检测到重复备份文件选择是否覆盖（交互）
- └ 更换国内源
  - └ 系统如果是 CentOS 选择是否安装/覆盖 EPEL 扩展国内源（交互）
- └ 选择是否更新软件包（交互）
- └ 选择是否清理已下载的软件包缓存（交互）

***

### 如何使用
> 1. 复制下面的完整命令到终端回车执行，如果执行出错或无法安装 `curl` 软件包，请复制源码到本地后手动执行。
> 2. 为了适配所有环境，请使用 `Root` 用户执行脚本，切换命令为 `sudo -i` 。
> 3. 执行脚本过程中会自动备份原有源无需手动备份，期间会在终端输出交互内容，可按回车键快速确认。
> 4. 脚本支持在原有源配置错误或者不存在的情况下使用，并且可以重复使用。

- `GNU/Linux` 一键更换国内软件源脚本

      bash <(curl -sSL https://gitee.com/SuperManito/LinuxMirrors/raw/main/ChangeMirrors.sh)
> __注意：__
> - _Debian 系 Linux 默认注释了源码仓库和预发布软件源，若需启用可将 list 源文件中的相关内容所在行 `取消注释`。_
> - _RedHat 系 Linux 配置了所有可以配置的仓库，但有一些仓库默认没有启用，若需启用可将 repo 源文件中的 `enabled=0`修改成 `enabled=1`。_

***

### 其它脚本
- `Docker` 国内一键安装脚本

      bash <(curl -sSL https://gitee.com/SuperManito/LinuxMirrors/raw/main/DockerInstallation.sh)
> _注意：脚本集成安装最新版的 `Docker Engine`与 `Docker Compose`，可手动选择 `Docker CE`源与 `Docker Hub`镜像加速器，目前脚本仅保证 Linux 发行版的最新稳定版可用，后续会加入 "手动选择安装版本" 功能，此脚本将在未来与此项目分离独立建项。_

***

### 常见问题与帮助
- 1. 如果提示 `Command 'curl' not found` 则说明当前未安装 `curl` 软件包，安装命令如下：

         sudo apt install -y curl  或  sudo yum install -y curl

- 2. 如果提示 `bash: /proc/self/fd/11: 没有那个文件或目录` ，请切换至 `Root` 用户执行。

***

### 捐助作者
<img src="./icon/thanks.jpg" width="250" height="250" alt="微信赞赏码"/><br/>

***

> 项目已设立开源许可协议，传播时需在显著位置标注来源和作者，请尊重本人的知识成果\
> 建议通过命令直接调用脚本，若有意见与建议您可以提交至 __Issues__，谢谢

***

__如果您觉得这个项目不错的话可以在右上角给颗⭐吗？方便分享给更多的朋友吗？__
