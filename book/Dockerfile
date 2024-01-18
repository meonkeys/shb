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

COPY Gemfile .

RUN bundle install

CMD ["/bin/bash", ".internal-build.sh"]
