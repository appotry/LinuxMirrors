# 已适配的 GNU/Linux 发行版：
| 系统 | 支持的版本 |
| ------ | ------ |
| Ubuntu | 16.04 ~ 20.10 |
| Debian | 8.0 ~ 10.7 |
| Kali | 2.0 ~ 2020.4 |
| Fedora | 28 ~ 33 |
| CentOS | 7.0 ~ 8.3 |
# 一键命令
__基于Debian系列 `Ubuntu | Debian | Kali`__

    bash <(curl -sL https://raw.githubusercontent.com/SuperManito/Shell/main/Source-Debians.sh)
__基于RedHat系列 `CentOS | Fedora`__

    bash <(curl -sL https://raw.githubusercontent.com/SuperManito/Shell/main/Source-RedHats.sh)
- 附1. 如果提示`Command 'curl' not found`则说明当前未安装`curl`软件包，安装命令如下：

      apt install -y curl 或 yum install -y curl
- 附2. 如果没有科学上网方式会提示无法解决`Hosts`，可通过添加解析记录以解决连通性问题，添加命令如下：

      echo "199.232.96.133 raw.githubusercontent.com" >> /etc/hosts
      echo "151.101.88.133 raw.githubusercontent.com" >> /etc/hosts
