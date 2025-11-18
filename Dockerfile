FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

RUN curl -sSL instl.vercel.app/teldrive | bash

ENTRYPOINT ["/usr/local/bin/teldrive"]
