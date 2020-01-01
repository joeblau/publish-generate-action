FROM swift:latest as builder
WORKDIR /root
COPY . .
RUN swift build -c release

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]