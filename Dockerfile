FROM golang:1.12.7-alpine3.9 as builder

RUN apk add --no-cache git gcc musl-dev && \
go get github.com/rubenv/sql-migrate/...

ENV GO111MODULE=on

COPY . /go/src/github.com/fukuyama012/cycle-reminder-api
RUN cd /go/src/github.com/fukuyama012/cycle-reminder-api && CGO_ENABLED=0 go build -o /go/bin/api


FROM alpine:latest

ENV GOPATH=/go
ENV REPO_ROOT=$GOPATH/src/github.com/fukuyama012/cycle-reminder-api

RUN apk add --update --no-cache tzdata && \
cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
echo "Asia/Tokyo" > /etc/timezone && \
apk del tzdata && rm -rf /var/cache/apk/*

RUN mkdir -p $REPO_ROOT/db
WORKDIR $REPO_ROOT

COPY --from=builder $GOPATH/bin/api api
COPY --from=builder $GOPATH/bin/sql-migrate sql-migrate
COPY --from=builder $REPO_ROOT/db/conf.yml db/conf.yml
COPY --from=builder $REPO_ROOT/db/migrations db/migrations

COPY devops/migrate.sh .

EXPOSE 1323
ENTRYPOINT ["./api"]