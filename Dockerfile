# First build, our React app
# Tagging this phase as a name. Could be named anything
FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# second configuration, second base image from docker hub
# Stops prior FROM block
# notice it also copies over the Build package from npm run build
# This is the run phase, not tagged
# EXPOSE needed for beanstalk
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html