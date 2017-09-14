# docker-riemann

[![Docker Pulls](https://img.shields.io/docker/pulls/mashape/kong.svg)](https://hub.docker.com/r/neetjn/riemann)

Docker image for Riemann network monitoring system version 0.2.11.

This image will target the `riemann.config` file in `/etc/riemann`, and target any accessory configurations via `/etc/riemann/conf.d/`.

### Docker CLI
```bash
docker pull neetjn/riemann:latest
```

### Dockerfile
```
FROM neetjn/riemann:latest
```

---
Copyright (c) 2017 John Nolette Licensed under the MIT license.
