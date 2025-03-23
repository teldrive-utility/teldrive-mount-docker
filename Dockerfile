FROM alpine:latest

RUN apk update && apk upgrade && apk add bash wget curl fuse3

RUN curl -sSL instl.vercel.app/rclone | bash

RUN sed -i 's/#user_allow_other/user_allow_other/' /etc/fuse.conf

ENTRYPOINT ["/bin/sh", "-c", "rclone --config /rclone.conf mount teldrive: /mount --allow-non-empty --allow-other --vfs-refresh --vfs-cache-max-age=24h --vfs-read-chunk-size=12M --vfs-read-chunk-streams=20 --teldrive-threaded-streams=1 --vfs-cache-mode=full --vfs-cache-max-size=$CACHE_SIZE --cache-dir /cache --no-modtime --links -v --debug-fuse"]
