FROM node

WORKDIR /opt/app
COPY package.json package-lock.json ./

RUN npm install

COPY . .

ENTRYPOINT ["npm", "run", "develop"]