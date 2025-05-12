FROM golang:1.24.3-bookworm

RUN useradd -m -d /home/app app
WORKDIR /home/app/src

COPY go.mod go.sum ./
RUN go mod download

COPY cmd/ cmd/
COPY lib/ lib/
COPY templates/ templates/
COPY main.go main.go
RUN go build -o build/fizzbuzz

EXPOSE 8080
USER app

CMD ["./build/fizzbuzz", "serve"]
