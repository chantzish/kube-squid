FROM ubuntu
WORKDIR /root
#ENV HOME=/root
RUN apt update && apt install -y squid && \
    sed -i 's/http_access/#http_access/' /etc/squid/squid.conf && \
    echo http_access allow all>>/etc/squid/squid.conf && \
    echo via off>> /etc/squid/squid.conf && \
    echo forwarded_for transparent>> /etc/squid/squid.conf
EXPOSE 3128/tcp
COPY Dockerfile /root/Dockerfile
CMD /usr/sbin/squid -YCN
