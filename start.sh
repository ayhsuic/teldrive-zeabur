#!/bin/bash
set -e

# --- Rclone 配置 ---
RCLONE_CONFIG="${RCLONE_CONFIG:-/.config/rclone/rclone.conf}"

# --- Remote 配置 ---
TELDRIVE_REMOTE_NAME="${TELDRIVE_REMOTE_NAME:-teldrive}"
TELDRIVE_API_HOST="${TELDRIVE_API_HOST:-https://tgdrive.zeabur.app}"

# --- 脚本执行 ---
echo "正在使用 rclone 命令生成配置文件..."
echo "[${TELDRIVE_REMOTE_NAME}]
type = teldrive
api_host = ${TELDRIVE_API_HOST}
access_token = ${ACCESS_TOKEN}" > "${RCLONE_CONFIG}"

echo "正在启动 Rclone WebDAV 服务..."
exec rclone serve webdav ${TELDRIVE_REMOTE_NAME}: \
    --config="${RCLONE_CONFIG}" \
    --addr "${WEBDAV_ADDR:-:8000}" \
    --user "${WEBDAV_USER:-ayhsuic}" \
    --pass "${WEBDAV_PASS:-Rc@12138}" \
    --vfs-cache-mode "${VFS_CACHE_MODE:-full}" \
    --cache-dir "${CACHE_DIR:-/cache}" \
    --vfs-cache-max-age "${VFS_CACHE_MAX_AGE:-72h}" \
    --vfs-cache-max-size "${VFS_CACHE_MAX_SIZE:-1024M}" \
    --dir-cache-time "${DIR_CACHE_TIME:-120h}" \
    --vfs-read-chunk-size="${VFS_READ_CHUNK_SIZE:-32M}" \
    --vfs-read-chunk-streams="${VFS_READ_CHUNK_STREAMS:-4}" \
    --vfs-write-back "${VFS_WRITE_BACK:-5s}" \
    --poll-interval "${POLL_INTERVAL:-1m}"
