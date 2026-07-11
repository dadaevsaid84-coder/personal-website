FROM nginx:alpine
COPY index.html style.css script.js profile.png /usr/share/nginx/html/
