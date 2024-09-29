# Use the official NGINX base image
FROM nginx:latest

# Copy the custom index.html to the NGINX html directory
COPY ./index.html /usr/share/nginx/html/index.html

# Expose port 80 to the outside world
EXPOSE 80

# Start the NGINX server
CMD ["nginx", "-g", "daemon off;"]
