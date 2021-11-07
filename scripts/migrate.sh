#!/bin/bash
# shellcheck disable=SC2039,SC2155,SC1091
. scripts/prod-env.sh
bin/snekinfo eval "Snekinfo.Release.migrate"
