FROM nginx:latest

ENV GITHUB_REPO https://github.com/shower2013/company-news/raw/master/build-artifacts
ENV STATIC_FILE companyNews.zip

RUN yum update -qq \
  && yum install -qqy curl wget unzip nano \
  && yum clean \
  \
  && wget -O /tmp/${STATIC_FILE} ${GITHUB_REPO}/${STATIC_FILE} \
  && unzip /tmp/${STATIC_FILE} -d /usr/share/nginx/assets/

COPY default.conf /etc/nginx/conf.d/default.conf

