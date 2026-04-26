FROM node:18-alpine AS jsdos

RUN apk add curl
WORKDIR site
RUN wget https://js-dos.com/6.22/current/js-dos.js && \
    wget https://js-dos.com/6.22/current/wdosbox.js && \
    wget https://js-dos.com/6.22/current/wdosbox.wasm.js
RUN npm install -g serve


FROM jsdos AS game

RUN curl -k -o game.zip "https://www.dosgames.com/files/GALAG101.ZIP"

FROM game AS web

COPY index.html bg.jpg ./
RUN sed -i s/GAME_ARGS/\"GALAGON.EXE\"/ index.html

EXPOSE 8000

ENTRYPOINT ["npx", "serve", "-l", "tcp://0.0.0.0:8000"]