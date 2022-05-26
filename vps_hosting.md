
Reverse proxy:
sudo docker rm proxy -f && sudo docker run -d --name proxy --net base  --restart on-failure -p 80:80 -p 443:443 -p 8999:8999 -e RESOLVER_ADDRESS="9.9.9.9 ipv6=off" -e SITES='app.test.com=containername:port;' -v ssl-data:/etc/resty-auto-ssl valian/docker-nginx-auto-ssl:latest

STAGING: 
-e LETSENCRYPT_URL="https://acme-staging-v02.api.letsencrypt.org/directory"