# Docker image for go-carbon + carbonapi + grafana

## Quick Start

```sh
docker run -d\
 --name go-graphite\
 --restart=always\
 -p 80:80\
 -p 2003-2004:2003-2004\
 gographite/go-graphite
```

### Includes the following components

* [Nginx](http://nginx.org/) - reverse proxies Grafana dashboard
* [Grafana](http://www.grafana.com/) - front-end dashboard
* [Go-carbon](https://github.com/lomik/go-carbon) - Golang implementation of Graphite/Carbon server
* [Carbonapi](https://github.com/go-graphite/carbonapi) - Golang implementation of Graphite-web

### Mapped Ports

Host | Container | Service
---- | --------- | -------------------------------------------------------------------------------------------------------------------
  80 |        80 | [grafana](http://docs.grafana.org/)
2003 |      2003 | [carbon receiver - plaintext](http://graphite.readthedocs.io/en/latest/feeding-carbon.html#the-plaintext-protocol)
2004 |      2004 | [carbon receiver - pickle](http://graphite.readthedocs.io/en/latest/feeding-carbon.html#the-pickle-protocol)

### Mounted Volumes

Host              | Container                  | Notes
----------------- | -------------------------- | -------------------------------
DOCKER ASSIGNED   | /etc/go-carbon             | go-carbon configs (see )
DOCKER ASSIGNED   | /var/lib/graphite          | graphite file storage
DOCKER ASSIGNED   | /etc/nginx                 | nginx config
DOCKER ASSIGNED   | /etc/grafana               | Grafana config
DOCKER ASSIGNED   | /etc/carbonapi             | Carbonapi config
DOCKER ASSIGNED   | /etc/logrotate.d           | logrotate config
DOCKER ASSIGNED   | /var/log                   | log files
