FROM docker.elastic.co/elasticsearch/elasticsearch:7.12.0

ADD elasticsearch/elasticsearch.yml /usr/share/elasticsearch/config/

USER root

RUN chown elasticsearch:elasticsearch config/elasticsearch.yml

USER elasticsearch