
Reverse proxy:
docker run -d -e LETSENCRYPT_EMAIL=name@example.org -v /var/run/docker.sock:/var/run/docker.sock:ro -p 80:80 -p 443:443 robbertkl/proxy


Note: "-l proxy.host=example.org,www.example.org":
docker run -d -l proxy.host=example.org,www.example.org <image>