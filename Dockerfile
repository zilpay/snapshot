FROM node:12.18.3 as build-stage


RUN exit 1
WORKDIR /app
COPY ./package.json ./
RUN yarn install
COPY . ./
RUN yarn build

FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]
