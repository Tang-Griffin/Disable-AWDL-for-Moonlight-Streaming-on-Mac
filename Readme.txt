在yuanbao帮助下经HF修改的程序组
当Moonlight在前台时，关闭awdl0，否则打开。
以7秒为等待时间持续判断
单次运行无需手动操作

原始代码组：
启动：
curl -sL https://raw.githubusercontent.com/meterup/awdl_wifi_scripts/main/awdl-daemon.sh | bash
禁用：
curl -s https://raw.githubusercontent.com/meterup/awdl_wifi_scripts/main/cleanup-and-reenable-awdl.sh | bash &> /dev/null

操作：
若要启动并将代码加入系统守护进程，在终端运行 awdl-daemon.sh
若要以后禁用脚本，在终端运行 cleanup-and-reenable-awdl.sh

原因：
Awdl会频繁切换wifi信道并造成网络不通畅，在moonlight连接时需禁用
可能有苹果互联相关副作用

基础代码：
关闭awdl0，会自动启动。如需打开，把down改为up即可：
sudo ifconfig awdl0 down
查看awdl0状态：
ifconfig awdl0