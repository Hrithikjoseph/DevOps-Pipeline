# Use the official Nginx image as a parent image
FROM nginx:alpine

# Copy the static website files into the Nginx server
COPY index.html /usr/share/nginx/html/
COPY main.css /usr/share/nginx/html/
COPY logo.svg /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# Start Nginx when the container has provisioned
CMD ["nginx", "-g", "daemon off;"]
