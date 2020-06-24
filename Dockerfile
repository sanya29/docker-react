FROM node:alpine 
WORKDIR '/app'
COPY package*.json ./
RUN npm install
COPY . . 
# don't need volumes because we're not concerned with immediately reflecting changed files
RUN npm run build 

# /app/build contains the files we care about

FROM nginx 
EXPOSE 80
COPY --from=0 /app/build /usr/share/nginx/html