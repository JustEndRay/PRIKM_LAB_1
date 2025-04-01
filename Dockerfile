# Use a specific stable version of the nginx image
FROM nginx:1.23.3

# Copy the nginx configuration file
COPY nginx.conf /etc/nginx/nginx.conf

# Copy static assets (index.html, styles.css)
COPY index.html /usr/share/nginx/html/
COPY styles.css /usr/share/nginx/html/

# Run an update on packages (to ensure base image is up-to-date)
RUN apt-get update && apt-get upgrade -y && apt-get clean

RUN apt-get update && apt-get upgrade -y && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set up nginx to run in the background (in case the base image needs it)
CMD ["nginx", "-g", "daemon off;"]

