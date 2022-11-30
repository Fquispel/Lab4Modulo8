FROM node:lts-alpine AS build-lab4
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx:stable-alpine as production-stage
COPY --from=build-lab4 /app/dist /usr/share/nginx/html
