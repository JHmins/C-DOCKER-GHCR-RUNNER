FROM ubuntu:24.04

RUN apt-get update && \
    apt-get install -y gcc make libc6 && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY src ./src
COPY Makefile .

RUN make

CMD ["./calculator"]

