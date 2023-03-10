# syntax=docker/dockerfile:1

FROM golang:latest as builder
WORKDIR /home/hyphengolang
COPY go.mod ./
RUN go mod download 
COPY . .
RUN CGO_ENABLED=0 go build -a -installsuffix cgo -o app .

FROM alpine:latest  
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /home/hyphengolang/app .
EXPOSE 8080
CMD ["./app"]