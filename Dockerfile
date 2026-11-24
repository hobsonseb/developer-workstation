FROM nginx:alpine

LABEL org.opencontainers.image.title="developer-workstation"

COPY site/ /usr/share/nginx/html/