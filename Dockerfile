FROM alpine:latest

ENV METHOD=aes-128-gcm PASSWORD=ss123456 USER=user
ENV PORT=80 WSPATH=u123456ws

ADD * /app/
RUN apk add --update --no-cache curl nginx bash sudo openssh \
  && adduser --disabled-password user \
  && sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config \
  && echo 'user:$1$xgO6/iR1$YWtCN9X8XlhQOyEmaSBSZ1' | chpasswd -e > /dev/null 2>&1 \
  && echo "user ALL=NOPASSWD: ALL" >> /etc/sudoers \
  && mv /app/default.conf /etc/nginx/http.d \
  && sed -i "s/wspath/$WSPATH/g" /etc/nginx/http.d/default.conf \
  && chmod a+x app/ctg /app/start.sh \
  && rm /app/Dockerfile

WORKDIR /app
EXPOSE $PORT

CMD exec /app/start.sh
