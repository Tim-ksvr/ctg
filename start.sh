#/bin/sh

/app/ctg -L="ss+mws://$METHOD:$PASSWORD@localhost:3580" -L="socks5+mws://$USER:$PASSWORD@localhost:3553?path=/$WSPATH" >/dev/null 2>&1 &
ssh-keygen -A
/usr/sbin/sshd -D -e "$@" &
crond
nginx -g 'daemon off;'
