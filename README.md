```bash
podman volume create static_volume
podman volume create media_volume

podman pod create -p 5432:5432 -p 8000:8000 -p 443:443 -p 80:80 --name studybuddy-pod

buildah bud -t localhost/studybuddy-django .
podman run --name studybud-app -d --pod studybuddy-pod -v "static_volume:/app/staticfiles:z" localhost/studybuddy-django

buildah bud -t localhost/studybuddy-nginx .
podman run --name studybuddy-nginx -d --pod studybuddy-pod -v "/root/certs:/etc/ssl/certs:z" -v "/root/private:/etc/ssl/private:z" -v "static_volume:/app/staticfiles:z" localhost/studybuddy-nginx
```