FROM ruby:3.2

RUN apt-get update \
  && apt-get --assume-yes --no-install-recommends install \
  bsdextrautils \
  && rm -rf /var/lib/apt/lists/*

ARG USER
ARG UID
ARG GROUP
ARG GID

WORKDIR /usr/src/app

RUN addgroup --gid $GID $USER \
  && useradd --uid $UID --gid $GID --shell /bin/bash --no-create-home $USER \
  && chown -R $USER:$GROUP /usr/src/app

USER "$USER:$GROUP"

ENV HOME=/usr/src/app

COPY Gemfile .

RUN bundle install

COPY .internal-build.sh Rakefile steadfast.asciidoc .

# absolute destination path required so dirs aren't flattened into $HOME
COPY img/ $HOME/img

CMD ["/bin/bash", ".internal-build.sh"]
