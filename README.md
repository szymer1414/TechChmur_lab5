# TechChmur_lab5

Tworzenia obrazu
sudo docker build --build-arg BASE_VERSION=19.8.1 -t lab5:v1 .

uruchomienie kontenera:
docker run -d -p 8080:8080 --name lab5 lab5:v1


docker ps
