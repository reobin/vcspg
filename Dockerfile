FROM ubuntu:latest

LABEL maintainer="Robin Gagnon<contact@reobin.dev>"
LABEL version="0.1"
LABEL description="The vim color scheme preview generator"

RUN apt-get update && apt-get install -y \
  vim \
  git

ENV TERM xterm-256color

WORKDIR /home/app

COPY ./src .

RUN chmod 755 generate_color_scheme_data.sh

# run
ENTRYPOINT ["sh", "generate_color_scheme_data.sh"]
# default args
CMD ["morhetz", "gruvbox"]
