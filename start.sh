#!/bin/sh
set -e

# 启动 teldrive
echo "Starting teldrive..."
/teldrive run --config /config/config.toml &

until curl -s http://localhost:8080/api/health; do
  echo "Waiting for Teldrive server..."
  sleep 5
done

# 启动 rclone
echo "正在生成 Rclone 配置文件: /config/rclone.conf"
echo "[teldrive]
type = teldrive
api_host = https://localhost:8080
access_token = ${TELDRIVE_ACCESS_TOKEN}" > "/config/rclone.conf"

echo "正在启动 Rclone WebDAV 服务..."
rclone mount teldrive:/ /media \
    --config "/config/rclone.conf" \
    --cache-dir=/cache \
    --vfs-cache-mode=full \
    --vfs-cache-max-age=72h \
    --vfs-cache-max-size=1024M \
    --dir-cache-time=120h \
    --vfs-read-chunk-size=4M \
    --vfs-read-chunk-streams=16 &

echo "Starting Jellyfin..."
/jellyfin/jellyfin
