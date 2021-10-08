FROM node:14 AS builder

WORKDIR /usr/src/app

COPY package*.json /usr/src/app/
RUN npm install

COPY babel.config.json .eslintrc *.js /usr/src/app/
COPY src /usr/src/app/src/

RUN npm run build

FROM nginx:alpine

COPY --from=builder /usr/src/app/build/ /usr/share/nginx/html/
WORKDIR /usr/share/nginx/html
