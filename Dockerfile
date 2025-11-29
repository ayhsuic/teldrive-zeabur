# 第一阶段：获取 teldrive
FROM ghcr.io/tgdrive/teldrive AS teldrive

# 第二阶段：获取 rclone
FROM ghcr.io/tgdrive/rclone AS rclone

# 第三阶段：使用 jellyfin 作为基础镜像
FROM jellyfin/jellyfin

RUN apt-get update && apt-get install -y fuse3 && rm -rf /var/lib/apt/lists/*

# 从前面的阶段复制二进制文件
COPY --from=teldrive /teldrive /teldrive
COPY --from=rclone /usr/local/bin/rclone /usr/local/bin/rclone

# 复制并设置启动脚本
COPY start.sh /start.sh
RUN chmod +x /start.sh
ENTRYPOINT ["/start.sh"]
