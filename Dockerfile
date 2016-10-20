# Pull base image
FROM node:0.12.14

# Install Aglio api-mock
RUN npm install -g aglio@latest
