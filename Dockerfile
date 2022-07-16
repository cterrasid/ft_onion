#syntax=docker/dockerfile:1
# Set the ubuntu filesystem
FROM ubuntu:20.04
# Update dependencies
RUN apt-get update
# Install nginx and ufw2 (firewall) and remove temp instalation files
RUN apt-get install -y nginx \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# Copy my custom nginx setup
COPY nginx.conf /etc/nginx/nginx.conf
# Copy my custom static page
COPY index.html /usr/share/nginx/html/
# Expose port 80
EXPOSE 80
# Command, IDK
CMD ["nginx", "-g", "daemon off;"]
