podman pod stop monitoring-pod
podman pod rm monitoring-pod
podman network rm mon-net
#echo "Creating network"
#podman network create mon-net
echo "Creating monitoring pod"
podman pod create -p 6379:6379 -p 8080:8080 -p 3000:3000 -p 9090:9090 --name=monitoring-pod

echo "Creating redis"
podman run --name=monitoring_redis -it -d --pod=monitoring-pod redis:latest
echo "Creating cadvisor"
podman run --name=monitoring_cadvisor -it -d --pod=monitoring-pod --mount type=bind,source=/,destination=/rootfs,ro --mount type=bind,source=/var/run,destination=/var/run,ro --mount type=bind,source=/sys,destination=/sys,ro --mount type=bind,source=/var/lib/containers/,destination=/var/lib/containers,ro --mount type=bind,source=/dev/disk,destination=/dev/disk,ro gcr.io/cadvisor/cadvisor
echo "Creating prometheus"
podman run --name=monitoring_prometheus -it -d --pod=monitoring-pod --mount type=bind,source=./prometheus.yml,destination=/etc/prometheus/prometheus.yml,ro prom/prometheus:latest --config.file=/etc/prometheus/prometheus.yml
echo "Creating grafana"
podman run --name=monitoring_grafana -it -d --pod=monitoring-pod grafana/grafana
