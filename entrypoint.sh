#!/bin/sh
# =============================================================================
# SOCKS5 Proxy Entrypoint Script
# =============================================================================
# Environment Variables:
#   SOCKS5_PORT - Listening port (default: 1080)
#   SOCKS5_USER - Username for authentication (optional)
#   SOCKS5_PASS - Password for authentication (optional)
# =============================================================================

set -e

PORT="${SOCKS5_PORT:-1080}"
USER="${SOCKS5_USER:-}"
PASS="${SOCKS5_PASS:-}"

# Build gost command
if [ -n "$USER" ] && [ -n "$PASS" ]; then
    # With authentication
    echo "Starting SOCKS5 proxy on port ${PORT} with authentication..."
    exec gost -L "socks5://${USER}:${PASS}@:${PORT}"
else
    # Without authentication
    echo "Starting SOCKS5 proxy on port ${PORT} without authentication..."
    exec gost -L "socks5://:${PORT}"
fi
