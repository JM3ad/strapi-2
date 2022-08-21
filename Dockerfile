FROM node as base

WORKDIR /opt/app
COPY package.json package-lock.json ./

RUN npm install

COPY . .

FROM base as dev
ENTRYPOINT ["npm", "run", "develop"]

FROM base as prod
ENV NODE_ENV=production
RUN npm run build
ENTRYPOINT [ "npm", "run", "start" ]