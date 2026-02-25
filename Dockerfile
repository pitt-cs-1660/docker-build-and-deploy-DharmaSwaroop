FROM golang:1.23 AS builder

WORKDIR /app

COPY go.mod .
COPY main.go .
COPY templates/ ./templates/

RUN CGO_ENABLED=0 go build -o Go_web_application .

FROM scratch

COPY --from=builder /app/Go_web_application /Go_web_application
COPY --from=builder /app/templates ./templates

ENTRYPOINT ["./Go_web_application"]