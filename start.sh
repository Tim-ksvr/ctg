#/bin/sh

/app/ctg -L="ss+mws://$METHOD:$PASSWORD@localhost:3580" -L="socks5+mws://$USER:$PASSWORD@localhost:3553?path=/$WSPATH" >/dev/null 2>&1 &
ssh-keygen -A
sed -i "s/wspath/$WSPATH/" /etc/nginx/http.d/default.conf
/usr/sbin/sshd -D -e "$@" &
[ -f "/mnt/vol/cron" ] && cat /mnt/vol/cron >>/var/spool/cron/crontabs/root
crond
nginx -g 'daemon off;'
