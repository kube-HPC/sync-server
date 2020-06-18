FROM node:10
RUN npm install -g tcp-over-websockets
CMD ["tcp-over-websockets-server"]