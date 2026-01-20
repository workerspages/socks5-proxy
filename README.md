# SOCKS5 代理服务器

[![构建状态](https://github.com/workerspages/socks5-proxy/actions/workflows/docker-build.yml/badge.svg)](https://github.com/workerspages/socks5-proxy/actions/workflows/docker-build.yml)

基于 [gost](https://github.com/ginuerzh/gost) 的轻量级 SOCKS5 代理服务器 Docker 镜像。

## 功能特性

- 🚀 轻量级 Alpine 基础镜像
- 🔐 支持无认证 / 用户名密码认证
- 🏗️ 多架构支持 (amd64, arm64)
- ⚙️ 通过环境变量简单配置

## 快速开始

### 拉取镜像

```bash
# 从 GitHub Container Registry
docker pull ghcr.io/workerspages/socks5-proxy:latest

# 从 Docker Hub
docker pull workerspages/socks5-proxy:latest
```

### 运行

**无认证模式：**

```bash
docker run -d --name socks5 -p 1080:1080 ghcr.io/workerspages/socks5-proxy:latest
```

**用户名密码认证模式：**

```bash
docker run -d --name socks5 -p 1080:1080 \
  -e SOCKS5_USER=admin \
  -e SOCKS5_PASS=your_password \
  ghcr.io/workerspages/socks5-proxy:latest
```

**自定义端口：**

```bash
docker run -d --name socks5 -p 8080:8080 \
  -e SOCKS5_PORT=8080 \
  ghcr.io/workerspages/socks5-proxy:latest
```

## 环境变量

| 变量名 | 默认值 | 说明 |
|--------|--------|------|
| `SOCKS5_PORT` | `1080` | 监听端口 |
| `SOCKS5_USER` | *(空)* | 认证用户名 |
| `SOCKS5_PASS` | *(空)* | 认证密码 |

> **注意：** 只有同时设置 `SOCKS5_USER` 和 `SOCKS5_PASS` 时才会启用认证。

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
      # 取消注释以启用认证
      # - SOCKS5_USER=admin
      # - SOCKS5_PASS=your_password
```

## 测试连接

```bash
# 无认证测试
curl -x socks5://127.0.0.1:1080 https://httpbin.org/ip

# 有认证测试
curl -x socks5://admin:your_password@127.0.0.1:1080 https://httpbin.org/ip
```

## 本地构建

```bash
docker build -t socks5-proxy:local .
```

## 许可证

MIT License
