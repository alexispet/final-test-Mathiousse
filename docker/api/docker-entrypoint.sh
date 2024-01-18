#!/bin/sh

if [ $NODE_ENV == "development" ]; then
  echo "executing npm install in dev mode"
  npm install
fi

# todo : do not run migration if already done
npm run db:import

exec "$@"