FROM node:22.3.0 AS base

WORKDIR /app

COPY ["package.json", "package-lock.json", "./"]

FROM base AS test
RUN npm ci
COPY . .
RUN npm run test

FROM base AS development
RUN npm ci
COPY . .
CMD ["npm", "run", "dev"]

FROM base AS production
RUN npm ci --production
COPY . .
CMD ["npm", "start"]