#!/usr/bin/env bash

echo "Publishing to github release"

set -x

FILE=$(ls packages/*.tgz)
echo curl -X POST \
    -H '"Content-Length: '$(stat --format=%s $FILE)'"' \
    -H '"Content-Type: '$(file -b --mime-type $FILE)'"' \
    -T '"'$FILE'"' \
    -H '"Authorization: token '$GITHUB_TOKEN'"' \
    -H '"Accept: application/vnd.github.v3+json"' \
    '"https://uploads.github.com/repos/bareboat-necessities/lysmarine_gen/releases/54202060/assets?name='$(basename $FILE)'"' >> upload.command

cat upload.command

# TODO:
#cat upload.command | xargs -0 -L 1 -I CMD -P 1 bash -c CMD