#!/bin/bash

if test "$1" = "--url"; then
	URL="$2"
        echo ">>$URL<<"
	shift
	shift
else
	URL="http://127.0.0.1:8000"
fi

if test "$1" = "--disable"; then
	export DOING="False"
else
	export DOING="True"
fi

export COOKIEFILE="/tmp/cookies.txt.ipfilter"
curl -c "$COOKIEFILE"  "${URL}/configure" >/dev/null
export CSRFTOKEN="$(cat "$COOKIEFILE" | grep "csrftoken" | awk '{print $7}')"



setup()
{
	echo ">>>>$1<<<<"
	export ID="$(echo "$1" | awk '{print $1}')"
	echo "ID=$ID"
	curl --header "X-CSRFToken: $CSRFTOKEN" -b "$COOKIEFILE" -X POST "${URL}/channels/${ID}" -H 'Content-Type: application/json' -d "{\"included\":\"$DOING\"}"
}


if [ -t 0 ]; then
	setup "$*"
else
	echo "pipe"
	while read zin
	do
		setup "$zin"
	done
fi
