FROM ubuntu
WORKDIR /root
ENV HOME=/root
ENV PORT=8080
RUN apt update && apt install -y squid git && \
    sed -i 's/http_access/#http_access/' /etc/squid/squid.conf && \
    echo http_access allow all>>/etc/squid/squid.conf && \
    echo via off>> /etc/squid/squid.conf && \
    echo forwarded_for transparent>> /etc/squid/squid.conf && \
    git clone https://github.com/novnc/noVNC.git /opt/noVNC && \
    git clone https://github.com/novnc/websockify /opt/noVNC/utils/websockify && \
    sed -i 's/${WEBSOCKIFY} ${SSLONLY} --web ${WEB}/${WEBSOCKIFY} ${SSLONLY} --heartbeat=45 --web ${WEB}/' /opt/noVNC/utils/launch.sh
EXPOSE 3128/tcp
EXPOSE 8080/tcp
COPY Dockerfile /root/Dockerfile
CMD /opt/noVNC/utils/websockify/run ${PORT:-8080} localhost:3128 --heartbeat=45 & /usr/sbin/squid -YCN
