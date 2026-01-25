FROM ghcr.io/tgdrive/teldrive AS teldrive

FROM ghcr.io/tgdrive/rclone AS rclone

FROM darthsim/imgproxy

ENV IMGPROXY_ALLOW_ORIGIN="*"
ENV IMGPROXY_ENFORCE_WEBP="true"
ENV IMGPROXY_MALLOC="jemalloc"
ENV IMGPROXY_BIND="8888"

COPY --from=teldrive /teldrive /teldrive
COPY --from=rclone /usr/local/bin/rclone /usr/local/bin/rclone

COPY start.sh /start.sh
RUN chmod +x /start.sh
ENTRYPOINT ["/start.sh"]
