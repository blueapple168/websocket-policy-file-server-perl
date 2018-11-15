FROM blueapple/baseimage:latest
MAINTAINER blueapple <blueapple1120@qq.com>

RUN apk update && \
    apk add perl \
    dumb-init

COPY docker-entrypoint.sh /deployments/docker-entrypoint.sh
WORKDIR /deployments
RUN curl -LO http://www.lightsphere.com/dev/articles/socketpolicy.tar.gz && \
    tar -xzf socketpolicy.tar.gz && \
    rm -rf socketpolicy.tar.gz && \
    rm -rf /var/cache/apk/* && \
    rm -rf /var/lib/apt/lists/*

# Auth
RUN chown -R root:root /deployments && \
    chmod +x /deployments/socketpolicy/socketpolicy.pl && \
    chmod +x /deployments/docker-entrypoint.sh && \
    touch /deployments/flash_socket_policy.log
    
EXPOSE 843
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/deployments/docker-entrypoint.sh"]
