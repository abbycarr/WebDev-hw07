#!/bin/bash

export MIX_ENV=prod
export PORT=4803

CFGD=$(readlink -f ~/.config/hw07)

if [ ! -e "$CFGD/bb" ]; then
	echo "run deploy first"
	exit 1
fi

DB_PASS=$(cat "$CFGD/db_plz")
export DATABASE_URL=ecto://hw07:$DB_PASS@localhost/hw07_prod


SECRET_KEY_BASE=$(cat "$CFGD/bb")
export SECRET_KEY_BASE


_build/prod/rel/hw07/bin/hw07 start

