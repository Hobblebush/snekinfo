#!/bin/bash
# shellcheck disable=SC2039,SC2155

export MIX_ENV=prod
export PORT=4801

export CONF_DIR="$HOME/.config/snekinfo"

# DB conf
USER=snekinfo
HOST=localhost
DB=snekinfo_prod

if [[ ! -d "$CONF_DIR" ]]; then
    mkdir -p "$CONF_DIR"
fi

if [[ ! -f "$CONF_DIR/secret" ]]; then
    dd if=/dev/urandom of=/tmp/seed bs=64 count=1
    sha256sum /tmp/seed | cut -d' ' -f1 > "$CONF_DIR/secret"
fi

if [[ ! -f "$CONF_DIR/dbpass" ]]; then
    echo "Put your DB password in $CONF_DIR/dbpass"
    exit 1
fi

export SECRET_KEY_BASE=$(cat "$CONF_DIR/secret")
PASS=$(cat "$CONF_DIR/dbpass")
export DATABASE_URL="ecto://$USER:$PASS@$HOST/$DB"
