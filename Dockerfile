# build stage
FROM golang AS build
WORKDIR /app
RUN apt-get update -y && \
    apt-get install upx -y
ADD ./hello-world.go /app
RUN cd /app && \
    go build -ldflags "-s -w" hello-world.go && \
    upx --brute hello-world

# final stage
FROM busybox
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ./hello-world