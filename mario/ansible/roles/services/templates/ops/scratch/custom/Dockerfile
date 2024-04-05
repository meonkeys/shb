# see https://github.com/meonkeys/docker-scratch

FROM node:21-alpine3.18

ENV SCRATCH_VERSION v3.6.18

RUN apk add git

WORKDIR /app

RUN git clone --depth=1 --branch $SCRATCH_VERSION https://github.com/LLK/scratch-gui.git \
  && cd scratch-gui \
  && npm install

EXPOSE 8601

WORKDIR /app/scratch-gui

# work around https://github.com/LLK/scratch-gui/issues/5682
RUN mv webpack.config.js webpack.config.js.bak
COPY webpack.config.js .

CMD ["npm", "start"]
