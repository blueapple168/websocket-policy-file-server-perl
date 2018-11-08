FROM docker pull blueapple/baseimage:base
MAINTAINER blueapple <blueapple1120@qq.com>

RUN apk add --update perl && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /workspace
ADD http://www.lightsphere.com/dev/articles/socketpolicy.tar.gz /workspace
WORKDIR /workspace
# Flash Player always tries port 843 first, if there's nothing listening on that port, then the Flash clients are going to experience a 3-second delay when trying to connect to your server. Even if you set up a policy file on the destination port, there will still be the delay. 
# For fastest response times, you should set up a server-wide socket policy server on port 843.
EXPOSE 843
CMD ["/workspace/socketpolicy/socketpolicy.pl",">","/dev/null"]
