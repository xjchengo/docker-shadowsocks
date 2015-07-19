FROM python
MAINTAINER Xujian Chen <xjchen@echo58.com>

# COPY sources.list /etc/apt/sources.list

# Set default configuration
COPY shadowsocks.json /etc/shadowsocks.json

# Install encryption tool
RUN apt-get update && \
    apt-get -y install build-essential \
    python-m2crypto

COPY libsodium-1.0.3.tar.gz /root/libsodium-1.0.3.tar.gz
RUN cd /root && \
    tar xf /root/libsodium-1.0.3.tar.gz && \
    cd libsodium-1.0.3 && \
    ./configure && \
    make -j2 && \
    make install && \
    ldconfig

# Install Shadowsocks
RUN pip install shadowsocks

ENV PASSWORD 123456
ENV TIMEOUT 300
ENV METHOD aes-256-cfb
ENV WORKERS 1

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["ssserver"]

EXPOSE 8388
