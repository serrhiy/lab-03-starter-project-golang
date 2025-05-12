FROM golang:1.24.3-bookworm AS build

WORKDIR /go/src/app

COPY go.mod go.sum ./
RUN go mod download

COPY cmd/ cmd/
COPY lib/ lib/
COPY templates/ templates/
COPY main.go main.go
RUN CGO_ENABLED=0 go build -o /go/bin/app

FROM gcr.io/distroless/static-debian12
EXPOSE 8080
COPY --from=build /go/bin/app /
COPY templates /templates
ENTRYPOINT ["./app", "serve"]
