FROM golang:1.13.4 AS build

WORKDIR /build
COPY serve ./serve
COPY main.go .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o server .

FROM scratch

COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=build /build/server /build/serve /
COPY --from=build /build/serve /serve

EXPOSE 2000

ENTRYPOINT ["/server"]
