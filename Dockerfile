FROM debian:bullseye-slim

RUN curl -sSL instl.vercel.app/teldrive | bash

ENTRYPOINT ["/usr/local/bin/teldrive"]
