# Use an official nginx image from the Docker hub
FROM nginx:latest

# Copy the HTML file to the nginx container
COPY index.html /usr/share/nginx/html/index.html

# Expose the default HTTP port
EXPOSE 80
