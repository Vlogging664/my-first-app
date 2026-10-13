
FROM nginx:alpine

# Allow Nginx to run under OpenShift's non-root security policy.
RUN sed -i '/^[[:space:]]*user[[:space:]]/d' /etc/nginx/nginx.conf \
    && sed -i 's|/var/run/nginx.pid|/tmp/nginx.pid|g; s|/run/nginx.pid|/tmp/nginx.pid|g' /etc/nginx/nginx.conf \
    && sed -i '/http {/a\    client_body_temp_path /tmp/nginx-client-temp;\n    proxy_temp_path /tmp/nginx-proxy-temp;\n    fastcgi_temp_path /tmp/nginx-fastcgi-temp;\n    uwsgi_temp_path /tmp/nginx-uwsgi-temp;\n    scgi_temp_path /tmp/nginx-scgi-temp;' /etc/nginx/nginx.conf

# Use an unprivileged port for OpenShift.
RUN sed -i 's/listen       80;/listen       8080;/' /etc/nginx/conf.d/default.conf
RUN echo 'Hello from my Docker image v1.5!' > /usr/share/nginx/html/index.html

EXPOSE 8080

