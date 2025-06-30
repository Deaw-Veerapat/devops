#!/bin/bash

TOKEN=$token
owner=$1
repo=$2
friend=$3

helper(){
if [ $# -ne 3 ]; then
	echo "put 3 argument"
	exit 1
else
	echo "good boyyyy"
fi;	
}
helper "$@"

addco(){
curl -L \
  -X PUT \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/${owner}/${repo}/collaborators/${friend} \
  -d '{"permission":"push"}'
}
addco
