FROM node:20-alpine as build

WORKDIR /app

COPY package*.json /app/ 
RUN npm install
COPY . .

RUN npm run build

#Final output
#New Image
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
COPY nginx/nginx.conf etc/nginx/nginx.conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]
