FROM ubuntu:24.04

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    gcc \
    make \
    libc6-dev && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY src ./src
COPY Makefile .

RUN make

CMD ["./calculator"]

