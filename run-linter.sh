#!/bin/sh

# Change directory to where this script is located
cd "$(dirname ${BASH_SOURCE[0]})"

if which swiftlint >/dev/null; then
  swiftlint
else
  echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi
