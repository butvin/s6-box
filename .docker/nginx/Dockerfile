FROM nginx:1.25.0

ARG env

COPY ./nginx.conf /etc/nginx/nginx.conf
RUN rm /etc/nginx/conf.d/default.conf
COPY ${env}/app.conf /etc/nginx/conf.d/

CMD ["nginx", "-g", "daemon off;"]

WORKDIR "/application"
