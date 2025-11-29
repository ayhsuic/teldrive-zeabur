#!/bin/sh
set -e

# 生成 teldrive 配置文件
echo "正在生成 Teldrive 配置文件: /telcloud/config.toml"
echo "[db]
data-source = \"${DB_DATA_SOURCE}\"
prepare-stmt = ${DB_PREPARE_STMT}

[db.pool]
enable = ${DB_POOL_ENABLE}

[jwt]
allowed-users = [\"${JWT_ALLOWED_USERS}\"]
secret = \"${JWT_SECRET}\"

[tg.uploads]
encryption-key = \"${TG_UPLOADS_ENCRYPTION_KEY}\"

[tg.stream]
multi-threads = ${TG_STREAM_MULTI_THREADS}
stream-buffers = ${TG_STREAM_STREAM_BUFFERS}" > "/telcloud/config.toml"

# 生成 Rclone 配置文件
echo "正在生成 Rclone 配置文件: /telcloud/rclone.conf"
echo "[teldrive]
type = teldrive
api_host = http://localhost:8080
access_token = ${TELDRIVE_ACCESS_TOKEN}
chunk_size = "512M"
upload_concurrency = 4
encrypt_files = false
random_chunk_name = false" > "/telcloud/rclone.conf"

# 启动 teldrive
echo "Starting teldrive..."
/teldrive run --config /telcloud/config.toml
