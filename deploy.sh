#!/bin/bash

export MIX_ENV=prod
# Common port range for this is 4000-10,000
# Valid port range for a user app to listen
# on is something like 1025-32767
export PORT=4803
export SECRET_KEY_BASE=insecure
export DATABASE_URL=ecto://hw07:bad@localhost/hw07_prod


mix deps.get --only prod
mix compile

CFGD=$(readlink -f ~/.config/hw07)

if [ ! -d "$CFGD" ]; then
    mkdir -p "$CFGD"
fi

if [ ! -e "$CFGD/bb" ]; then
    mix phx.gen.secret > "$CFGD/bb"
fi

if [ ! -e "$CFGD/db_plz" ]; then
    pwgen 12 1 > "$CFGD/db_plz"
fi

SECRET_KEY_BASE=$(cat "$CFGD/bb")
export SECRET_KEY_BASE

DB_PASS=$(cat "$CFGD/db_plz")
export DATABASE_URL=ecto://hw07:$DB_PASS@localhost/hw07_prod


# mix ecto.create
mix ecto.migrate

(cd assets && npm install && webpack --mode production)
(cd assets && npm run deploy)
mix phx.digest

mix release


