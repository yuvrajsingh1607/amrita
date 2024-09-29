# Step 1: Use the official NGINX base image
FROM nginx:latest

# Step 2: Copy your custom content to the default NGINX html folder
COPY ./index.html /usr/share/nginx/html/index.html

# Expose port 80 to the outside world
EXPOSE 80

# Step 3: Start NGINX
CMD ["nginx", "-g", "daemon off;"]
