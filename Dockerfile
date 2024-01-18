FROM node:20-alpine as build

COPY . /app

WORKDIR /app

RUN npm install

COPY . .

FROM node:20-alpine as cicd-api

LABEL org.containers.images.source https://github.com/alexispet/final-test-mathiousse

WORKDIR /app

COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/package.json .
COPY --from=build /app/database ./database
COPY --from=build /app/app.js .

COPY docker/api/docker-entrypoint.sh /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint
ENTRYPOINT ["sh", "/usr/local/bin/docker-entrypoint"]

EXPOSE 3000
CMD ["npm", "start"]

