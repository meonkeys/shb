FROM node:19-alpine3.16

RUN apk add git

WORKDIR /app

RUN git clone https://github.com/LLK/scratch-gui.git \
  && cd scratch-gui \
  && git checkout v1.8.10 \
  && npm install

WORKDIR /app/scratch-gui

EXPOSE 8601

# work around https://github.com/LLK/scratch-gui/issues/7890
ENV NODE_OPTIONS=--openssl-legacy-provider

RUN npm run build

# work around https://github.com/LLK/scratch-gui/issues/5682
RUN mv webpack.config.js webpack.config.js.bak
COPY webpack.config.js .

CMD ["npm", "start"]
