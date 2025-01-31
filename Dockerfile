# Use Ubuntu Xenial as the base image
FROM ubuntu:xenial

# Set non-interactive mode for apt
ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and install mooproxy
RUN apt-get update && \
    apt-get install -y python3 mooproxy && \
    rm -rf /var/lib/apt/lists/*

# Ensure the mooproxy config directory exists
RUN mkdir -p /root/.mooproxy/worlds/

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Copy the connection hash script
COPY generate_mooproxy_hash.py /usr/local/bin/generate_mooproxy_hash.py
RUN chmod +x /usr/local/bin/generate_mooproxy_hash.py

# Expose the default mooproxy port
EXPOSE 7777

# Set entrypoint to generate config before running
ENTRYPOINT ["/entrypoint.sh"]
