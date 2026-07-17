# ===========================
# Stage 1 - Build Stage
# ===========================
FROM node:20 AS builder

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

# If you have a build step (TypeScript, React, etc.)
# RUN npm run build

# ===========================
# Stage 2 - Runtime Stage
# ===========================
FROM node:20-alpine

WORKDIR /app

COPY package*.json ./

RUN npm install --omit=dev

COPY --from=builder /app .

EXPOSE 3000

CMD ["npm","start"]