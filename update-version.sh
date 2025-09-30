#!/bin/bash

# Get the latest git commit hash and date
COMMIT_HASH=$(git log -1 --format="%h")
COMMIT_DATE=$(git log -1 --format="%ad" --date=format:"%b %d, %Y")
COMMIT_TIME=$(git log -1 --format="%ad" --date=format:"%I:%M %p")

VERSION="Build $COMMIT_HASH • $COMMIT_DATE • $COMMIT_TIME"

# Update the version in index.html using perl for cross-platform compatibility
perl -i -pe "s/>(Build|v)[^<]+</>${VERSION}</" index.html

echo "✅ Version updated to: $VERSION"

