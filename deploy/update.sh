#!/bin/bash

set -e

source "./constants.sh"

LOCAL_QUADLET_DIR=$REPO_DIR/quadlet

sync_to_server () {
    echo "Syncing $1 to $SSH_DEST:$2"
    ssh -T $SSH_DEST "mkdir -p $2"
    rsync -avP --delete $1 $SSH_DEST:$2
}

sync () {
    sync_to_server $LOCAL_QUADLET_DIR $REMOTE_QUADLET_DIR
}

start_quadlet() {
    #Show daemon-reload results
    echo ""
    echo "Doing dry run."
    #ssh -T $SSH_DEST 'echo $(/etc/systemd/system-generators/podman-system-generator --user --dryrun | grep quadlet-generator)' #Should display errors concisely.
    ssh -T $SSH_DEST 'echo $(/etc/systemd/system-generators/podman-system-generator --dryrun | grep quadlet-generator)' #Should display errors concisely.
    #ssh -T $SSH_DEST '/etc/systemd/system-generators/podman-system-generator --user --dryrun' #Should display generator output verbosely.

    echo ""
    echo "Daemon reload."
    ssh -T $SSH_DEST "systemctl --user daemon-reload"
    #ssh -T $SSH_DEST "systemctl daemon-reload"

    #Build can take a long time. Can follow along on a separate ssh session with
    #journalctl --user -fxeu shmashmexa-build

    source $LOCAL_QUADLET_DIR/members.sh
    for MEMBER in ${QUADLET_MEMBERS[@]}
    {
        echo "Starting $MEMBER"
        #ssh -T $SSH_DEST "systemctl --user restart $MEMBER"
        ssh -T $SSH_DEST "systemctl restart $MEMBER"
    }
}

sync
start_quadlet