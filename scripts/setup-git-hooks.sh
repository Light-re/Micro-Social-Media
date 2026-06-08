#!/bin/sh
cd "$(dirname "$0")/.." || exit 1
git config core.hooksPath .githooks
echo "Git hooks enabled: core.hooksPath=.githooks"
