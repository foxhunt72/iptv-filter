#!/bin/bash

if ! [ -d data ]; then
	mkdir data
fi

if ! [ -f "data/db.sqlite3" ]; then
	echo "initial setup"
	IPTV_SAFE_START=1 python3 manage.py migrate
fi


python3 manage.py runserver 0:8000 --noreload
