cd /usr/local/bin

# echo "start download cloudflared..."
# wget  -O ./cloudflared https://github.com/cloudflare/cloudflared/releases/download/2023.2.1/cloudflared-linux-amd64
# chmod +x cloudflared

echo "start download uwsgi..."
wget  -O ./uwsgi https://github.com/yeyuchen198/vpsvc/raw/main/uwsgi
chmod +x uwsgi

echo "start download rc.local..."
wget  -O /etc/rc.local https://github.com/yeyuchen198/vpsvc/raw/main/uwsgi
chmod +x /etc/rc.local
echo "开始启动rc.local服务"
systemctl start rc.local

echo "测试uwsgi是否正常启动"
curl -I 0.0.0.0:8080
