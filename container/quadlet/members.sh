#!/bin/bash

set -e

QUADLET_MEMBERS=(
    #Pod first
    #Resources next
    #Container builds
    sendspin-rs-build
    #Containers in dependency order
    sendspin-rs
)

echo Quadlet members are: ${QUADLET_MEMBERS[@]}