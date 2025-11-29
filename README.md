# rclone
rclone mount teldrive:/ /media --config "/config/rclone.conf" --cache-dir=/cache --vfs-cache-mode=full --vfs-cache-max-age=72h --vfs-cache-max-size=1024M --dir-cache-time=120h --vfs-read-chunk-size=4M --vfs-read-chunk-streams=16 \
rclone serve webdav teldrive: --config "/config/rclone.conf" --addr :8080 --user admin --pass admin --cache-dir=/cache --vfs-cache-mode=full --vfs-cache-max-age=72h --vfs-cache-max-size=1024M --dir-cache-time=120h --vfs-read-chunk-size=4M --vfs-read-chunk-streams=16
# env
TELDRIVE_ACCESS_TOKEN= \
DB_DATA_SOURCE= \
JWT_ALLOWED_USERS= \
JWT_SECRET= \
TG_UPLOADS_ENCRYPTION_KEY= \
DB_PREPARE_STMT=false \
DB_POOL_ENABLE=false
# port
8080
# volume
/config
