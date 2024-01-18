FROM node:21.5.0-alpine3.19 AS install

COPY . /app/

WORKDIR /app

RUN npm install

FROM node:21.5.0-alpine3.19 AS api

LABEL org.opencontainers.image.source https://github.com/alexispet/final-test-alexandre-kakal.git

WORKDIR /app

COPY --from=install /app/package.json .
COPY --from=install /app/node_modules ./node_modules
COPY --from=install /app/app.js ./app.js
COPY --from=install /app/database ./database

EXPOSE 3000

COPY docker/api/docker-entrypoint.sh /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint

ENTRYPOINT [ "docker-entrypoint" ]
CMD ["npm", "run", "start"]