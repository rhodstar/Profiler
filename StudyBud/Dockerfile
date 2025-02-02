# Use an official Python runtime based on Debian 10 "buster" as a parent image.
FROM python:3.9.1-slim-buster

# Add user that will be used in the container.
RUN useradd djuser

# Port used by this container to serve HTTP.
EXPOSE 8000

# Set environment variables.
# 1. Force Python stdout and stderr streams to be unbuffered.
# 2. Set PORT variable that is used by Gunicorn. This should match "EXPOSE"
#    command.
ENV PYTHONUNBUFFERED=1 \
    PORT=8000

ENV STUDYBUD_DATABASE_NAME=studybuddb
ENV STUDYBUD_DATABASE_USER=dbuser
ENV STUDYBUD_DATABASE_PASSWORD=admin
ENV STUDYBUD_DATABASE_HOST=127.0.0.1
ENV STUDYBUD_DATABASE_PORT=5432

# Install system packages required by Wagtail and Django.
RUN apt-get update --yes --quiet && apt-get install --yes --quiet --no-install-recommends \
    build-essential \
    libpq-dev \
    libmariadbclient-dev \
    libjpeg62-turbo-dev \
    zlib1g-dev \
    libwebp-dev \
 && rm -rf /var/lib/apt/lists/*

# Install the application server.
RUN pip install --upgrade pip
RUN pip install "gunicorn==20.0.4"

# Install the project requirements.
COPY requirements.txt /
RUN pip install -r /requirements.txt

# Use /app folder as a directory where the source code is stored.
WORKDIR /app

# Set this directory to be owned by the "djuser" user.
RUN chown djuser:djuser /app

# Copy the source code of the project into the container.
COPY --chown=djuser:djuser . .

# Use user "djuser" to run the build commands below and the server itself.
USER djuser

# Collect static files.
RUN python manage.py collectstatic --noinput --clear

# Runtime command that executes when "docker run" is called, it does the
# following:
#   1. Migrate the database.
#   2. Start the application server.
# WARNING:
#   Migrating database at the same time as starting the server IS NOT THE BEST
#   PRACTICE. The database should be migrated manually or using the release
#   phase facilities of your hosting platform. This is used only so the
#   Wagtail instance can be started with a simple "docker run" command.
CMD set -xe; python manage.py migrate --noinput; gunicorn studybud.wsgi:application