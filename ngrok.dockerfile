# Use Alpine Linux base image
FROM alpine:latest

# Install necessary packages
RUN apk update && \
    apk add --no-cache \
    curl \
    unzip

# Download ngrok binary from official source
RUN curl -Lo ngrok.zip https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-arm64.zip && \
    unzip ngrok.zip -d /usr/local/bin && \
    rm ngrok.zip && \
    chmod +x /usr/local/bin/ngrok

# Set the entrypoint for ngrok
ENTRYPOINT ["ngrok"]

# Default command options for ngrok HTTP tunnel
CMD ["http", "--log=stdout", "--log-level=info", "--region=us"]
