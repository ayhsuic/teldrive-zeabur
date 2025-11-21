#!/bin/sh

# 设置一个陷阱，当脚本退出时，杀死所有后台任务
trap 'kill $(jobs -p)' EXIT

# 启动 teldrive
echo "Starting teldrive..."
/teldrive run &

# 启动 rclone
echo "正在生成 Rclone 配置文件: /config/rclone.conf"
echo "[teldrive]
type = teldrive
api_host = https://${TELDRIVE_DOMAIN}.zeabur.app
access_token = ${TELDRIVE_ACCESS_TOKEN}" > "/config/rclone.conf"

echo "正在启动 Rclone WebDAV 服务..."
rclone serve webdav teldrive: \
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
