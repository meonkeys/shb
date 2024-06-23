# Linux, maybe Windows Dockerfile for making an image to build the book.

FROM ruby:3.3

RUN apt-get update \
  && apt-get --assume-yes --no-install-recommends install \
  epubcheck \
  && rm -rf /var/lib/apt/lists/*

ARG WORK_DIR

ENV HOME=$WORK_DIR

WORKDIR $WORK_DIR

COPY .Gemfile Gemfile

RUN bundle install

ENTRYPOINT ["/bin/python3", ".internal-build.py"]
