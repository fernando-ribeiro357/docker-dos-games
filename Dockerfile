FROM node:18-alpine AS jsdos

RUN apk add curl
WORKDIR site
RUN wget https://js-dos.com/6.22/current/js-dos.js && \
    wget https://js-dos.com/6.22/current/wdosbox.js && \
    wget https://js-dos.com/6.22/current/wdosbox.wasm.js
RUN npm install -g serve


FROM jsdos AS game

ARG GAME_URL
RUN curl -k -o game.zip "$GAME_URL"

FROM game AS web

ARG GAME_ARGS
COPY index.html bg.jpg ./
RUN sed -i s/GAME_ARGS/$GAME_ARGS/ index.html

ENTRYPOINT ["npx", "serve", "-l", "tcp://0.0.0.0:8000"]