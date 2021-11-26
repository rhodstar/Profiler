echo "Doing some cleaning"
podman pod stop monitoring
podman rm $(podman container ls -aq)
podman rmi gcr.io/cadvisor/cadvisor
podman pod rm monitoring
podman network rm mon-net
