FROM ubuntu:latest

LABEL maintainer="Robin Gagnon<contact@reobin.dev>"
LABEL version="0.1"
LABEL description="Generator for vim color scheme preview"

ENV TERM xterm-256color

RUN apt-get update && apt-get install -y \
  vim \
  git

COPY ./src .
