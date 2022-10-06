# [I BLOCK] Copying and installing our service 
FROM node:16-alpine as builder 

WORKDIR /app

COPY package.json .
RUN npm install

COPY . .
RUN npm run build

# [II BLOCK] Installing the nginx
FROM nginx
# The --from I want to copy over something from the other phase
# We tell we want to copy the build folder from the previous phase into the folder usr/share...
#                What to copy - Copy To
# Everything in that nginx folder will be served to the browser when it starts up.
COPY --from=builder /app/build /usr/share/nginx/html


