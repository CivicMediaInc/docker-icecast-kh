# Icecast-KH in Docker

## Run

Run with default password, export port 8000

```bash
sudo docker run -p 8000:8000 ykmn/icecast-kh
$BROWSER localhost:8000
```

Run with custom passwords

```bash
sudo docker run -d --name icecast-kh -p 8000:8000 \
     -v /etc/localtime:/etc/localtime:ro \
     -v /var/log/icecast:/var/log/icecast \
     -e ICECAST_SOURCE_PASSWORD=aaaa -e ICECAST_ADMIN_PASSWORD=bbbb \
     -e ICECAST_PASSWORD=cccc -e ICECAST_RELAY_PASSWORD=dddd ykmn/icecast-kh
```

Run with custom configuration

```bash
sudo docker run -d --name icecast-kh -p 56565:8000 \
     -v /etc/localtime:/etc/localtime:ro \
     -v /var/log/icecast:/var/log/icecast \
     -v /usr/local/etc/icecast5.xml:/etc/icecast.xml ykmn/icecast-kh
$BROWSER localhost:56565
```
*You may need to create /var/log/icecast on host for Icecast-Docker logs.*


Copy your icecast.xml to docker image: add to Dockerfile

```Dockerfile
FROM ykmn/icecast-kh
ADD ./icecast.xml /etc/icecast.xml
```

Docker-compose

```yaml
icecast:
  image: ykmn/icecast-kh
  volumes:
  - /var/log/icecast:/var/log/icecast
  - /etc/localtime:/etc/localtime:ro
  environment:
  - ICECAST_SOURCE_PASSWORD=aaa
  - ICECAST_ADMIN_PASSWORD=bbb
  - ICECAST_PASSWORD=ccc
  - ICECAST_RELAY_PASSWORD=ddd
  - ICECAST_LOCATION=Earth
  - ICECAST_ADMIN=john@doe.com
  - ICECAST_HOSTNAME=stream.doe.com
  ports:
  - 8000:8000
```

```yaml
icecast:
  image: ykmn/icecast-kh
  volumes:
  - /usr/local/etc/icecast5.xml:/etc/icecast.xml 
  - /var/log/icecast:/var/log/icecast
  - /etc/localtime:/etc/localtime:ro
  environment:
  - ICECAST_LOCATION=Earth
  - ICECAST_ADMIN=john@doe.com
  ports:
  - 56565:8000
```


## License

[MIT](https://github.com/ykmn/docker-icecast-kh/blob/master/LICENSE.md)
