FROM node as build

COPY . /app

WORKDIR /app

EXPOSE 3000

RUN npm install

FROM build as runner

COPY --from=build /app/node_modules /app/
COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]

CMD ["npm","run", "start"]