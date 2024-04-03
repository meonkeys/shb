FROM ruby:3.3

RUN apt-get update \
  && apt-get --assume-yes --no-install-recommends install \
  epubcheck \
  && rm -rf /var/lib/apt/lists/*

ARG WORK_DIR
ARG USER
ARG UID
ARG GROUP
ARG GID

RUN addgroup --gid $GID $USER \
  && useradd --uid $UID --gid $GID --shell /bin/bash --no-create-home $USER

USER "$USER:$GROUP"

ENV HOME=$WORK_DIR

WORKDIR $WORK_DIR

COPY .Gemfile Gemfile

RUN bundle install

USER root:root

COPY ./text_transformer.rb /usr/local/bundle/gems/asciidoctor-pdf-2.3.15/lib/asciidoctor/pdf/text_transformer.rb

USER "$USER:$GROUP"

ENTRYPOINT ["/bin/python3", ".internal-build.py"]
