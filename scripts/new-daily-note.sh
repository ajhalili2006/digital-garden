#!/usr/bin/env bash
set -xe

GITROOT=$(git rev-parse --show-toplevel)
DATE=$(TZ=Asia/Manila date +%Y-%m-%d)
DATEFILE="${GITROOT}/daily-notes/$DATE.md"

if [ ! -f "$DATEFILE" ]; then
  cp "$GITROOT/templates/daily note template.md" $DATEFILE
fi

$(command -v code || command -v code-insiders || $EDITOR) $DATEFILE