# docker-riemann

[![Docker Pulls](https://img.shields.io/docker/pulls/mashape/kong.svg)](https://hub.docker.com/r/neetjn/riemann)

Docker image for Riemann network monitoring system version 0.2.11.

This image will target the `riemann.config` configuration file in `/etc/riemann/`, if you're building an image with this repo locally then the Dockerfile will copy the configuration in this repository for you.

Any accessory configurations can be copied to the directory `/etc/riemann/conf.d/`.

InfluxDB integration is not included in this image, but can be done by adding the following to your configuration:
```clojure
;; InfluxDB database details where Riemann will store the data. Setup :username and :password
;; if you added security step behind riemann database access.

(def influxdb-creds {
     :version :0.9
     :host "localhost"
     :port 8086
     :db "riemann"
     ; :username "riemann"
     ; :password "riemann"
})

(def influxBatchSender
  (batch 100 1/10
         (async-queue! :agg {:queue-size 1000
                             :core-pool-size 1
                             :max-pool-size 4
                             :keep-alive-time 60000}
                       (influxdb influxdb-creds))))
                       
;; Expire states from its core's index every 60 seconds. Default is 10.

(periodically-expire 60)

(let [index (index)]
  (streams
   (default :ttl 60
     index
     #(info %)
     influxBatchSender)))
```

Read more on emitting events to InfluxDB [here](http://riemann.io/api/riemann.influxdb.html#var-influxdb).

### Docker CLI
```bash
docker pull neetjn/riemann:latest
```

### Dockerfile
```
FROM neetjn/riemann:latest
```

### Usage
```bash
docker run -p 5555:5555 -p 5556:5556 --name riemann-container neetjn/riemann:latest
```

---
Copyright (c) 2017 John Nolette Licensed under the MIT license.
