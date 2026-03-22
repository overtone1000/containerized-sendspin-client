#!/bin/bash

set -e

QUADLET_MEMBERS=(
    #Pod first
    #Resources next
    #Container builds
    sendspin-build
    #Containers in dependency order
    sendspin
)

echo Quadlet members are: ${QUADLET_MEMBERS[@]}