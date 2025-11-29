#!/bin/sh
set -e

# 生成 teldrive 配置文件
echo "正在生成 Teldrive 配置文件: /config/config.toml"
echo "[db]
data-source = \"${DB_DATA_SOURCE}\"
prepare-stmt = ${DB_PREPARE_STMT}

[db.pool]
enable = ${DB_POOL_ENABLE}

[jwt]
allowed-users = [\"${JWT_ALLOWED_USERS}\"]
secret = \"${JWT_SECRET}\"

[tg.uploads]
encryption-key = \"${TG_UPLOADS_ENCRYPTION_KEY}\"" > "/config/config.toml"

# 生成 Rclone 配置文件
echo "正在生成 Rclone 配置文件: /config/rclone.conf"
echo "[teldrive]
type = teldrive
api_host = http://localhost:8080
access_token = ${TELDRIVE_ACCESS_TOKEN}" > "/config/rclone.conf"

# 启动 teldrive
echo "Starting teldrive..."
/teldrive run --config /config/config.toml
