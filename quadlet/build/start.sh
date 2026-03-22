#!/bin/bash

set -e

echo Starting $NAME $ID $SERVER_URL

sendspin --list-audio-devices
sendspin daemon --id "$ID" --name "$NAME" --url "$SERVER_URL"