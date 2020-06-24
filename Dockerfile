FROM node:alpine as builder 
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . . 
# don't need volumes because we're not concerned with immediately reflecting changed files
RUN npm run build 

# /app/build contains the files we care about

FROM nginx 
COPY --from=builder /app/build /usr/share/nginx/html