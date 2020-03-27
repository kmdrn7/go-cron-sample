############################
# build executable binary
############################
FROM golang:alpine AS builder
RUN apk update && apk add --no-cache git
WORKDIR $GOPATH/src/app
COPY . .
# Fetch dependencies.
# Using go get.
RUN go get -d -v
# Build the binary.
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -ldflags="-w -s" -o /go/bin/app

############################
# build docker image
############################
FROM scratch
# Copy our static executable.
COPY --from=builder /go/bin/app /go/bin/app
# Run the hello binary.
ENTRYPOINT ["/go/bin/app"]
