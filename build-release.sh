#!/bin/sh

# Change directory to where this script is located
cd "$(dirname ${BASH_SOURCE[0]})"

swift package clean
swift build --configuration release
