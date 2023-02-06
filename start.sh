#/bin/sh

/app/ctg -L="ss+mws://$METHOD:$PASSWORD@localhost:3580" -L="socks5+mws://$USER:$PASSWORD@localhost:3553?path=$PATH" >/dev/null 2>&1 &
ssh-keygen -A
/usr/sbin/sshd -D -e "$@" &
crond
sed -i "s/##path##/$PATH/g" /etc/nginx/http.d/default.conf
nginx -g 'daemon off;'
