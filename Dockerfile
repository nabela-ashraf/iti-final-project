# Build stage
FROM golang:1.18 AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY *.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -o /go-docker

# Run stage
FROM alpine:3.14

WORKDIR /app

COPY --from=builder /go-docker /app/go-docker

EXPOSE 9090

CMD ["/app/go-docker"]
