# 第一阶段：获取 teldrive
FROM ghcr.io/tgdrive/teldrive AS teldrive

# 第二阶段：获取 rclone
FROM ghcr.io/tgdrive/rclone

# 从前面的阶段复制二进制文件
COPY --from=teldrive /teldrive /teldrive

# 复制并设置启动脚本
COPY start.sh /start.sh
RUN chmod +x /start.sh
ENTRYPOINT ["/start.sh"]
