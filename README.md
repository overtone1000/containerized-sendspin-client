Sendspin client running in a container

--mount type=bind,source=/run/user/1000/pipewire-0,dst=/pipewire/pipewire-0  \
    -e PIPEWIRE_RUNTIME_DIR=/pipewire \

Run with
```
podman run -it \
    --group-add keep-groups \
    --device /dev/snd:/dev/snd \
    sendspin
```

Group adding may be necessary but wasn't needed for HDMI device in testing.
Privilaged wasn't necessary.

Useful commands:
```
sendspin --list-audio-devices
sendspin --id sendspin_test --name "Sendspin Test" --url ws://10.10.10.10:8927/sendspin
```

Confirmed this worked but definitely had to specify the HDMI device. Didn't seem to work with just the jack device. Conflicting processes?

Test audio
```
podman run --rm -it \
  --device /dev/snd:/dev/snd \
  --group-add keep-groups \
  fedora:latest \
  bash -c "dnf install -y alsa-utils && speaker-test -t sine -f 440 -l 1"
```