# syntax=docker/dockerfile:1

# =============================================================================
# SOCKS5 Proxy Docker Image based on gost
# https://github.com/ginuerzh/gost
# =============================================================================

FROM golang:1.21-alpine AS builder

# Install build dependencies
RUN apk add --no-cache git

# Build gost from source
ARG GOST_VERSION=v2.11.5
RUN git clone --branch ${GOST_VERSION} --depth 1 https://github.com/ginuerzh/gost.git /src/gost \
    && cd /src/gost/cmd/gost \
    && CGO_ENABLED=0 go build -ldflags="-s -w" -o /gost

# =============================================================================
# Final image
# =============================================================================

FROM alpine:3.19

LABEL org.opencontainers.image.title="SOCKS5 Proxy"
LABEL org.opencontainers.image.description="A lightweight SOCKS5 proxy server based on gost"
LABEL org.opencontainers.image.source="https://github.com/workerspages/socks5-proxy"

# Install ca-certificates for HTTPS support
RUN apk add --no-cache ca-certificates

# Copy gost binary
COPY --from=builder /gost /usr/local/bin/gost

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Default SOCKS5 port
EXPOSE 1080

# Environment variables
ENV SOCKS5_PORT=1080
ENV SOCKS5_USER=""
ENV SOCKS5_PASS=""

ENTRYPOINT ["/entrypoint.sh"]
