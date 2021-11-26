#/bin/bash
podman generate systemd --files --name monitoring
mv *.service $HOME/.config/systemd/user
systemctl --user enable pod-monitoring.service
