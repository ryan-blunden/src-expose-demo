# Interim Dockerfile for demo and local testing purposes
FROM sourcegraph/alpine:3.9@sha256:e9264d4748e16de961a2b973cc12259dee1d33473633beccb1dfb8a0e62c6459

RUN apk add --no-cache git

# Change to force a fresh download src-expose
ENV LAST_UPDATED=2019-10-11

# Copy locally built binary
COPY ./src-expose /usr/local/bin/src-expose

# Download the latest uploaded binary using a cache bust param
# RUN BINARY_URL=https://storage.googleapis.com/sourcegraph-artifacts/src-expose/latest/darwin-amd64/src-expose?v=$LAST_UPDATED && \
#     wget -O /usr/local/bin/src-expose $BINARY_URL && \
#     chmod +x /usr/local/bin/src-expose

WORKDIR /usr/app/data/
USER sourcegraph
CMD ["src-expose"]
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/src-expose"]
EXPOSE 3434
