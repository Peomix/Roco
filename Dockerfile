FROM python:3.12-alpine
WORKDIR /app
COPY . .
CMD [ "tail", "f" ,"/dev/null"]