FROM node:20 as build
COPY . /app

WORKDIR /app

EXPOSE 3000

RUN npm install

FROM build as runner

COPY --from=build /app/node_modules /app/

COPY docker-compose.prod.yml /app/docker-compose.prod.yml

COPY docker/api/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT [ "docker-entrypoint.sh" ]

CMD ["npm","run", "start"]