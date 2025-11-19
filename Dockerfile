FROM ghcr.io/tgdrive/rclone:latest

RUN curl -sSL instl.vercel.app/teldrive | bash

COPY start.sh /start.sh
RUN chmod +x /start.sh

ENTRYPOINT ["/start.sh"]
