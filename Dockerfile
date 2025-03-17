FROM ruby:3.3.6-alpine


ENV LANG=C.UTF-8
ENV TZ=Asia/Tokyo
ARG RAILS_ENV=development
ENV USER_ID="1000"
ENV GROUP_ID="1000"
ENV USER_NAME="app"

RUN addgroup --gid "${GROUP_ID}" "${USER_NAME}" && \
  adduser  -u "${USER_ID}" "${USER_NAME}"  -G "${USER_NAME}" -D  && \
  chmod -R 777 /usr/local/bundle


RUN mkdir /app

RUN apk update && \
  apk upgrade && \
  apk add --no-cache tzdata bash

COPY . ./

# comment : run build on bin/build.sh
ENTRYPOINT ["/app/dockers/entrypoint.sh"]
