FROM nginx:alpine
 RUN echo 'Hello from my Docker image v1.1!' > /usr/share/nginx/html/index.html
