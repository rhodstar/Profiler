podman pod kill studybuddy-pod
podman pod rm studybuddy-pod
podman rmi studybuddy-django
podman rmi studybuddy-nginx
podman volume rm static_volume

podman volume create static_volume

podman pod create -p 5432:5432 -p 8000:8000 -p 443:443 -p 80:80 --name studybuddy-pod

buildah bud -t localhost/studybuddy-django StudyBud/
podman run --name studybuddy-django -d --pod studybuddy-pod -v "static_volume:/app/staticfiles:z" localhost/studybuddy-django

buildah bud -t localhost/studybuddy-nginx nginx/
podman run --name studybuddy-nginx -d --pod studybuddy-pod -v "/root/certs:/etc/ssl/certs:z" -v "/root/private:/etc/ssl/private:z" -v "static_volume:/app/staticfiles:z" localhost/studybuddy-nginx