FROM node:8.8.1

WORKDIR /app

COPY package.json ./
COPY package-lock.json ./

RUN ["npm", "install"]

ENTRYPOINT ["npm", "start"]
