#!/bin/sh
set -e

# 启动 teldrive
echo "Starting teldrive..."
/teldrive run --config /config/config.toml &

# 启动 rclone
echo "正在生成 Rclone 配置文件: /config/rclone.conf"
echo "[teldrive]
type = teldrive
api_host = http://localhost:8080
access_token = ${TELDRIVE_ACCESS_TOKEN}" > "/config/rclone.conf"

echo "Starting Jellyfin..."
/jellyfin/jellyfin
