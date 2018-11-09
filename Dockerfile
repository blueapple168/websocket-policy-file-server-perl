FROM blueapple/baseimage:latest AS downloadfile

WORKDIR /root
RUN curl -LO http://www.lightsphere.com/dev/articles/socketpolicy.tar.gz && \
    tar -xzf socketpolicy.tar.gz && \
    rm -rf socketpolicy.tar.gz

FROM perl:5.28-slim
RUN mkdir -p /workspace
WORKDIR /workspace
COPY --from=downloadfile /root/socketpolicy /workspace/socketpolicy
EXPOSE 843
CMD ["/workspace/socketpolicy/socketpolicy.pl",">","/dev/null"]
