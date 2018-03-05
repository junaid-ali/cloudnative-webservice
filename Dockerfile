FROM golang:1.9 as builder

WORKDIR /go/src/github.com/audip/cloudnative-webservice
COPY main.go .
RUN go get -d -v
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM alpine:3.6
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /go/src/github.com/audip/cloudnative-webservice/app .
CMD ["./app"]