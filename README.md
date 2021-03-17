__如果您觉得这个项目不错的话可以在右上角给颗⭐吗？方便分享给更多的朋友吗？__

***

# GNU/Linux 一键更换国内更新源脚本
| 操作系统  |   支持的版本   |
| :------: | :-----------: |
| Ubuntu   | 14.04 ~ 20.10 |
| Debian   | 8.0 ~ 10.8    |
| Fedora   | 28 ~ 33       |
| CentOS   | 7.0 ~ 8.3     |
| Kali     | 2.0 ~ 2021.1  |
> 仅支持 Debian 与 Redhat 发行版和及其衍生发行版

> `CentOS` 和 `Fedora` 配置了所有可以配置的仓库，但有一些仓库默认没有启用\
> 若需启用请将 `repo` 文件中的 `enabled=0` 修改成 `enabled=1` 

***

## 一键命令：
    bash <(curl -sSL https://gitee.com/SuperManito/LinuxMirrors/raw/main/ChangeMirror.sh)
> 脚本自带备份功能，无需手动备份原有官方源

***

## 其它脚本
- `Docker CE` 国内一键安装脚本：

      bash <(curl -sSL https://gitee.com/SuperManito/LinuxMirrors/raw/main/install-docker.sh)
> ㅤ默认配置阿里云镜像加速器

***

## 常见问题与帮助：
- 如果提示 `Command 'curl' not found` 则说明当前未安装 `curl` 软件包，安装命令如下：

      apt install -y curl 或 yum install -y curl

***

> 项目已设立开源许可证书，所有脚本不得用于商业目的，请尊重本人的知识成果\
> 如需使用请直接调用脚本，不要复制后进行传播，如有意见与建议请提交至 Issues

***

### <img src="https://g.csdnimg.cn/static/logo/favicon32.ico" width="16" height="16" alt="CSDN LOGO"/> CSDN博客：[blog.csdn.net/u013246692/article/details/113124295](https://blog.csdn.net/u013246692/article/details/113124295)
__如果您觉得这个项目不错的话可以在右上角给颗⭐吗？方便分享给更多的朋友吗？__
