#!/bin/sh
set -e

# 启动 teldrive
echo "Starting teldrive..."
teldrive run \
  --db-data-source "postgresql://postgres.lxtvteqdrzkltluemwuk:aaTwJBbYvNkkw9Sh@aws-1-ap-southeast-2.pooler.supabase.com:6543/postgres" \
  --db-prepare-stmt false \
  --db-pool-enable false \
  --jwt-allowed-users ayhsuic \
  --jwt-secret "ff78a167361bc2df18e1fb1702a95f96" \
  --tg-uploads-encryption-key "bWgWZsvd3_26oe4OYPy-7afv6uutbW" &

# 启动 rclone
echo "正在生成 Rclone 配置文件: /config/rclone.conf"
echo "[teldrive]
type = teldrive
api_host = https://localhost:8080
access_token = ${TELDRIVE_ACCESS_TOKEN}" > "/config/rclone.conf"

echo "正在启动 Rclone WebDAV 服务..."
rclone mount teldrive:/ /media/teldrive \
    --config "/config/rclone.conf" \
    --addr :8080 \
    --user "${WEBDAV_USER}" \
    --pass "${WEBDAV_PASS}" \
    --cache-dir /cache \
    --vfs-cache-mode full \
    --vfs-cache-max-age 72h \
    --vfs-cache-max-size 1024M \
    --dir-cache-time 120h \
    --vfs-read-chunk-size 4M \
    --vfs-read-chunk-streams 16 &

# 在前台启动 jellyfin，保持容器运行
echo "Starting Jellyfin..."
/jellyfin/jellyfin
