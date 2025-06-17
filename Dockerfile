FROM node:18-slim
RUN mkdir -p /app  
WORKDIR /app
COPY . .
