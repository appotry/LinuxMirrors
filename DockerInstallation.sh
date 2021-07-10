#!/bin/bash
echo -e "\n\033[33m[WARN]\033[0m 你正在通过旧命名执行该脚本，如想在今后继续使用，请使用新命令执行"
echo -e "\n\033[32m新命令：wget https://gitee.com/SuperManito/LinuxMirrors/raw/main/DockerInstallation.x -O install.x && chmod +x install.x && ./install.x\033[0m\n"
echo -e "倒计时 10 秒后开始执行脚本...\n"
for ((sec = 10; sec > 0; sec--)); do
    echo -e "$sec...\n"
    sleep 1
done
wget -q --no-check-certificate https://gitee.com/SuperManito/LinuxMirrors/raw/main/DockerInstallation.x -O install.x && chmod +x install.x && ./install.x
