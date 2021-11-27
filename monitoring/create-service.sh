#/bin/bash
sudo podman generate systemd --files --name monitoring
#mv *.service $HOME/.config/systemd/user
sudo mv *.service /etc/systemd/system/
#systemctl --user enable pod-monitoring.service
sudo systemctl enable pod-monitoring.service
