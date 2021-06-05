# Docker image for go-carbon + carbonapi + grafana

## Quick Start

```sh
docker run -d\
 --name go-graphite\
 --restart=always\
 -p 80:80\
 -p 8080:8081\
 -p 8125:8125/udp\
 -p 2003-2004:2003-2004\
 gographite/go-graphite
```

### Includes the following components

* [Go-carbon](https://github.com/lomik/go-carbon) - Golang implementation of Graphite/Carbon server
* [Carbonapi](https://github.com/go-graphite/carbonapi) - Golang implementation of Graphite-web
* [Brubeck](https://github.com/github/brubeck) - C implementation Statsd

### Mapped Ports

Host | Container | Service
---- | --------- | -------------------------------------------------------------------------------------------------------------------
2003 |      2003 | [carbon receiver - plaintext](http://graphite.readthedocs.io/en/latest/feeding-carbon.html#the-plaintext-protocol)
2004 |      2004 | [carbon receiver - pickle](http://graphite.readthedocs.io/en/latest/feeding-carbon.html#the-pickle-protocol)
8125 |      8125 | [statsd receiver - udp](https://github.com/b/statsd_spec)

### Exposed Ports

Container | Service
--------- | -------------------------------------------------------------------------------------------------------------------------
   8081   | [carbonapi](https://github.com/go-graphite/carbonapi/blob/master/doc/configuration.md#general-configuration-for-carbonapi)

### Mounted Volumes

Host              | Container                  | Notes
----------------- | -------------------------- | -------------------------------
DOCKER ASSIGNED   | /etc/go-carbon             | go-carbon configs (see )
DOCKER ASSIGNED   | /var/lib/graphite          | graphite file storage
DOCKER ASSIGNED   | /etc/carbonapi             | Carbonapi config
DOCKER ASSIGNED   | /etc/logrotate.d           | logrotate config
DOCKER ASSIGNED   | /var/log                   | log files
