FROM golang:1.19 as builder

WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 go build -o app -trimpath -tags netgo -ldflags='-extldflags=-static -w -s'

FROM gcr.io/distroless/base-debian10

USER nonroot:nonroot
WORKDIR /app
COPY --from=builder /app/app /usr/local/bin/cronner

CMD ["/usr/local/bin/cronner"]
