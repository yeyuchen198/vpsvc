# 检测是否安装warp
if [[ "$(whereis warp | grep /bin/warp)" != "" ]]
then
    echo "warp安装！"
else
    echo "warp未安装！开始安装warp"
    wget -N https://raw.githubusercontent.com/fscarmen/warp/main/menu.sh && bash menu.sh
fi
# 可以单独安装warp，注释掉上面即可




cd /usr/local/bin


# echo "修改DNS64解析"
# cp /etc/resolv.conf /etc/resolv_backup.conf
# wget -O /etc/resolv.conf https://raw.githubusercontent.com/yeyuchen198/vpsvc/main/resolv.conf

echo "开放TCP 8080端口"
iptables -I INPUT -p tcp --dport 8080 -j ACCEPT
# 查看iptables开放列表
# iptables -L -n -v


# echo "start download cloudflared..."
# wget -O ./cloudflared https://github.com/cloudflare/cloudflared/releases/download/2023.2.1/cloudflared-linux-amd64
# chmod +x cloudflared

echo "start download uwsgi..."
wget -O ./uwsgi https://github.com/yeyuchen198/vpsvc/raw/main/uwsgi
chmod +x uwsgi

echo "开始设置开机自启"
echo "start download rc-local.service..."
curl -o /etc/systemd/system/rc-local.service -L https://raw.githubusercontent.com/yeyuchen198/vpsvc/main/rc-local.service
sudo systemctl enable rc-local

echo "start download rc.local..."
wget -O /etc/rc.local https://raw.githubusercontent.com/yeyuchen198/vpsvc/main/rc.local
chmod +x /etc/rc.local

echo "开始启动rc.local服务"
# 参考：https://www.linuxbabe.com/linux-server/how-to-enable-etcrc-local-with-systemd
sudo systemctl start rc-local.service
sudo systemctl status rc-local.service

echo "测试uwsgi是否正常启动"
curl -I 0.0.0.0:8080

