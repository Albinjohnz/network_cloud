created a Dockerfile -file will define the steps to build the Docker image with Nginx configured to serve index.html
also created a simple html application(index.html)

docker build -t sample-app .
docker run -d -p 80:80 sample-app