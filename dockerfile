FROM golang:1.23 as base
WORKDIR /app
COPY go.mod .
RUN go mod download
COPY . .
run go build -o main .

FROM gcr.io/distroless/base
copy --from=base /app/main .
copy --from=base /app/static ./static
EXPOSE 8080
cmd ["./main"]