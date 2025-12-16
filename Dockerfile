FROM node:18-alpine
RUN apk add --no-cache openssl

EXPOSE 3000

WORKDIR /app

ENV NODE_ENV=production

COPY package.json package-lock.json* ./

RUN npm install --omit=dev && npm cache clean --force
RUN npm remove @shopify/cli

COPY . .

RUN npm run build

CMD ["sh", "-c", "remix-serve ./build/server/index.js --port $PORT"]
