FROM nginx:1.21-alpine

ENV FONTS_HOST='http://localhost'

RUN apk add --no-cache \
    bash

COPY ./conf/nginx.conf.template /etc/nginx/nginx.conf.template
COPY ./docker-entrypoint.sh /
RUN chmod a+x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]
