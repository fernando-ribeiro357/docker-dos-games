FROM node:18-alpine AS jsdos

WORKDIR site
RUN wget https://js-dos.com/6.22/current/js-dos.js && \
    wget https://js-dos.com/6.22/current/wdosbox.js && \
    wget https://js-dos.com/6.22/current/wdosbox.wasm.js
RUN npm install -g serve

FROM jsdos AS game

COPY tetrisqueen.zip game.zip

FROM game AS web

COPY index.html bg.jpg ./
RUN sed -i s/GAME_ARGS/\"QTETRIS.EXE\"/ index.html

EXPOSE 8000

ENTRYPOINT ["npx", "serve", "-l", "tcp://0.0.0.0:8000"]