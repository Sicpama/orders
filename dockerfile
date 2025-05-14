FROM mysql:8.2                                       
ENV TZ=UTC
# These environment variables will be provided at runtime
# Default values are only used for development
ARG MYSQL_DATABASE=orders
ARG MYSQL_USER
ARG MYSQL_PASSWORD

ENV MYSQL_DATABASE=${MYSQL_DATABASE}
ENV MYSQL_USER=${MYSQL_USER}
ENV MYSQL_PASSWORD=${MYSQL_PASSWORD}

# Copy your SQL dump into the init directory; it will be executed on first startup
COPY dump.sql.gz /docker-entrypoint-initdb.d/
