# Microsoft SQL server base image.
FROM mcr.microsoft.com/mssql/server:2022-latest

# Set Accept EULA, required for installing some of the mssql packages.
ENV ACCEPT_EULA=Y

# Install prerequisites and tools required for building.
USER root
RUN apt-get update && \
    apt-get install -y curl gnupg git python3 python3-pip supervisor && \
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update && \
    apt-get install -y msodbcsql17 mssql-tools unixodbc-dev gcc && \
    echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc

# Copy repo into /app folder.
COPY mock-app/ /app/

# Install Python packages and dependencies.
RUN pip3 install --no-cache-dir -r /app/requirements.txt

# Copy supervisord config. 
COPY supervisord/ /etc/supervisor/conf.d/

# Add start-up script.
COPY scripts/start.sh /start.sh

# Set the correct permissions for the start up script.
RUN chmod +x /start.sh

# Run start up script.
ENTRYPOINT ["/start.sh"]