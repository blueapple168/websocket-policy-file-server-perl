FROM blueapple/baseimage:latest
MAINTAINER blueapple <blueapple1120@qq.com>

RUN apk update && \
    apk add perl \
    dumb-init

RUN mkdir -p /workspace
WORKDIR /workspace
RUN curl -LO http://www.lightsphere.com/dev/articles/socketpolicy.tar.gz && \
    tar -xzf socketpolicy.tar.gz && \
    rm -rf socketpolicy.tar.gz && \
    rm -rf /var/cache/apk/* && \
    rm -rf /var/lib/apt/lists/*
    
# Auth
RUN chown -R root:root /workspace && \
    chmod +x /workspace/socketpolicy/socketpolicy.pl
    
EXPOSE 843
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/workspace/socketpolicy/socketpolicy.pl",">","/dev/null","&"]
