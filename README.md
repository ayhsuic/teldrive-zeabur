# teldrive-zeabur
rclone mount teldrive:/ /media \
    --config "/config/rclone.conf" \
    --cache-dir=/cache \
    --vfs-cache-mode=full \
    --vfs-cache-max-age=72h \
    --vfs-cache-max-size=1024M \
    --dir-cache-time=120h \
    --vfs-read-chunk-size=4M \
    --vfs-read-chunk-streams=16 &
