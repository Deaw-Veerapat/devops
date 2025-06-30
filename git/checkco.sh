#!/bin/bash

Token=$token

Owner=$1
Repo=$2
helper(){
if [ $# -ne 2 ]; then
        echo "put 2 agument"
        exit 1
fi;
}
helper "$@"
get_api() {
    curl -L \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer ${Token}" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    "https://api.github.com/repos/${Owner}/${Repo}/collaborators"
}
filter(){
	get_api | jq -r '.[] | select(.permissions.pull == true) | .login'
}

collaborators=$(filter)

if [ -z "$collaborators" ]; then
    echo "No collaborators with pull access found"
else
    echo "$collaborators"
fi
