echo "Doing some cleaning"
sudo podman pod stop monitoring
sudo podman rm $(podman container ls -aq)
sudo podman pod rm monitoring
sudo podman network rm mon-net
