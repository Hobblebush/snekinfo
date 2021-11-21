#!/bin/bash

USER=snekinfo
HOST=rarity.reptigene.com

scripts/release.sh

scp /tmp/snekinfo-release.tar.gz "$USER@$HOST:~"
ssh "$USER@$HOST" tar xzvf snekinfo-release.tar.gz
ssh "$USER@$HOST" "bash -c '(cd snekinfo && scripts/migrate.sh)'"
ssh "$USER@$HOST" "bash -c '(cd snekinfo && scripts/restart.sh)'"

echo
echo "Deploy complete. Remember to verify that the site still loads."
echo
