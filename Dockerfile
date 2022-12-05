#develop stage
FROM node:lts-alpine as develop-stage
RUN npm install -g @vue/cli
WORKDIR /app
COPY package*.json ./
RUN npm install --silent
RUN yarn install
COPY ./ .

CMD [ "npm", "run", "serve" ]

#build stage
FROM develop-stage as build-stage
RUN yarn build
#production stage
FROM ngnix:stable-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80