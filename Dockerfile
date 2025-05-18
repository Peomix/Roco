FROM python:3.9-slim

WORKDIR /app

RUN echo "Roco run in Python" 

COPY . . 
