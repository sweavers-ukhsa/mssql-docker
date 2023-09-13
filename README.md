# README

## 1. Building the Docker Image.

`docker build -t mssql-docker:latest .`

## 2. Running a Container from the Image.

`docker run -e 'SA_PASSWORD=DefaultPassword123' --name mssql -d mssql-docker:latest`

## 3. Check the logs to confirm the database has started.

`docker logs mssql`
