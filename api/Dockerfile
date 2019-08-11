FROM golang:1.12.7-alpine3.9 as builder

ENV GO111MODULE=on

COPY . /go/src/github.com/fukuyama012/cycle-reminder-api/api
WORKDIR /go/src/github.com/fukuyama012/cycle-reminder-api/api

RUN apk add --no-cache git \
&& CGO_ENABLED=0 go build -o /go/bin/api

FROM alpine:latest
COPY --from=builder /go/bin/api /go/bin/api
ENTRYPOINT ["/go/bin/api"]