FROM centos

RUN yum install wget -y
RUN wget -O /usr/bin/jq https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64
RUN chmod +x /usr/bin/jq

COPY docker-entrypoint /
ENTRYPOINT ["/docker-entrypoint"]

HEALTHCHECK --interval=5s CMD exit 0

CMD ["autoheal"]
