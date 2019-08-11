FROM golang:1.12.7-alpine3.9 as builder

ENV GO111MODULE=on

COPY . /go/src/github.com/fukuyama012/cycle-reminder-api/api
WORKDIR /go/src/github.com/fukuyama012/cycle-reminder-api/api

RUN apk add --no-cache git && \
CGO_ENABLED=0 go build -o /go/bin/api

FROM alpine:latest
RUN apk add --update --no-cache tzdata && \
cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
echo "Asia/Tokyo" > /etc/timezone && \
apk del tzdata && rm -rf /var/cache/apk/*

COPY --from=builder /go/bin/api /go/bin/api
EXPOSE 1323
ENTRYPOINT ["/go/bin/api"]