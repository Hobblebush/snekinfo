#!/bin/bash
# shellcheck disable=SC2039,SC2155,SC1091
. scripts/prod-env.sh

mix deps.get --only prod
mix compile
if [[ ! -f _build/sass ]]; then
    mix sass.install
fi
mix assets.deploy
mix release

cp -r scripts _build/prod/rel/snekinfo

TAR=/tmp/snekinfo-release.tar.gz
(cd _build/prod/rel && tar czf $TAR snekinfo)
ls -l $TAR
