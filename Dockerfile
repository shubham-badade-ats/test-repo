
FROM httpd:latest
# Copy index.html file into the container
COPY ./index.html /usr/local/apache2/htdocs/

# Expose port 80 (HTTP)
EXPOSE 80