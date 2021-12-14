#/bin/bash
sudo podman generate systemd --files --name monitoring-pod
sudo mv *.service /etc/systemd/system/
sudo systemctl enable pod-monitoring-pod.service
