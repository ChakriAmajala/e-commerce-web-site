FROM nginx:alpine
COPY . /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
<<<<<<< HEAD

=======
>>>>>>> a8f6963 (new datt)

