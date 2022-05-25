#!/bin/bash

if test "$1" = "--url"; then
	shift
fi

export URL="${1:-http://127.0.0.1:8000}"

curl "${URL}/channels" | jq -r '.[] | "\(.pk) \(.included) \(.group_title) \(.tvg_name)"'
