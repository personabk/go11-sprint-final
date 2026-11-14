FROM golang:1.22-alpine AS builder
COPY tracker.db /tracker.db
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build -o tracker .
FROM alpine:latest
COPY --from=builder /app/tracker /tracker
CMD ["./tracker"]