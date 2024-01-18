#!/bin/sh

if [ "$NODE_ENV" = "development" ]; then
  npm install
fi

echo "DB_HOST is set to $DB_HOST"

npm run db:import

exec "$@"
  