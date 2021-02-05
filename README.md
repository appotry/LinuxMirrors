# 已适配的 GNU/Linux 发行版：
| 系统 | 支持的版本 |
| ------ | ------ |
| Ubuntu | 14.04 ~ 20.10 |
| Debian | 8.0 ~ 10.7 |
| Kali | 2.0 ~ 2020.4 |
| Fedora | 28 ~ 33 |
| CentOS | 7.0 ~ 8.3 |
# 一键命令
- __Github:__

      bash <(curl -sL https://raw.githubusercontent.com/SuperManito/LinuxMirrors/main/ReplaceMirror.sh)
- __Gitee:__

      bash <(curl -sL https://gitee.com/SuperManito/LinuxMirrors/raw/main/ReplaceMirror.sh)
# 基于 RedHat 系列 Linux 官方源一键生成脚本
- __Github:__

      bash <(curl -sL https://raw.githubusercontent.com/SuperManito/LinuxMirrors/main/RedHat-Official-Mirror-Generation.sh)
- __Gitee:__

      bash <(curl -sL https://gitee.com/SuperManito/LinuxMirrors/raw/main/RedHat-Official-Mirror-Generation.sh)
- 附1. 如果提示`Command 'curl' not found`则说明当前未安装`curl`软件包，安装命令如下：

      apt install -y curl 或 yum install -y curl
- 附2. 如果没有科学上网方式使用Github命令部署项目时提示`无法解决Hosts`，可通过添加解析记录以解决连通性问题，添加命令如下：

      echo "199.232.96.133 raw.githubusercontent.com" >> /etc/hosts
      echo "151.101.88.133 raw.githubusercontent.com" >> /etc/hosts
