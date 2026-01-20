# SOCKS5 Proxy

[![Build and Push Docker Image](https://github.com/workerspages/socks5-proxy/actions/workflows/docker-build.yml/badge.svg)](https://github.com/workerspages/socks5-proxy/actions/workflows/docker-build.yml)

A lightweight SOCKS5 proxy server based on [gost](https://github.com/ginuerzh/gost).

## Features

- 🚀 Lightweight Alpine-based image
- 🔐 Optional username/password authentication
- 🏗️ Multi-architecture support (amd64, arm64)
- ⚙️ Simple configuration via environment variables

## Quick Start

### Pull Image

```bash
# From GitHub Container Registry
docker pull ghcr.io/workerspages/socks5-proxy:latest

# From Docker Hub
docker pull workerspages/socks5-proxy:latest
```

### Run

**Without authentication:**

```bash
docker run -d --name socks5 -p 1080:1080 ghcr.io/workerspages/socks5-proxy:latest
```

**With authentication:**

```bash
docker run -d --name socks5 -p 1080:1080 \
  -e SOCKS5_USER=admin \
  -e SOCKS5_PASS=your_password \
  ghcr.io/workerspages/socks5-proxy:latest
```

**Custom port:**

```bash
docker run -d --name socks5 -p 8080:8080 \
  -e SOCKS5_PORT=8080 \
  ghcr.io/workerspages/socks5-proxy:latest
```

## Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `SOCKS5_PORT` | `1080` | Listening port |
| `SOCKS5_USER` | *(empty)* | Username for authentication |
| `SOCKS5_PASS` | *(empty)* | Password for authentication |

> **Note:** Authentication is only enabled when both `SOCKS5_USER` and `SOCKS5_PASS` are set.

## Docker Compose

```yaml
version: '3.8'

services:
  socks5:
    image: ghcr.io/workerspages/socks5-proxy:latest
    container_name: socks5-proxy
    restart: unless-stopped
    ports:
      - "1080:1080"
    environment:
      - SOCKS5_PORT=1080
      # Uncomment for authentication
      # - SOCKS5_USER=admin
      # - SOCKS5_PASS=your_password
```

## Test Connection

```bash
# Test without authentication
curl -x socks5://127.0.0.1:1080 https://httpbin.org/ip

# Test with authentication
curl -x socks5://admin:your_password@127.0.0.1:1080 https://httpbin.org/ip
```

## Build Locally

```bash
docker build -t socks5-proxy:local .
```

## License

MIT License
