#!/bin/bash
set -e

# Wait for database if DB_HOST is set
if [ -n "$DB_HOST" ]; then
  echo "Waiting for database..."
  until pg_isready -h ${DB_HOST} -U ${DB_USER:-postgres} 2>/dev/null; do
    echo "Database not ready, waiting..."
    sleep 2
  done
  echo "Database ready!"
fi

# Run migrations
python manage.py migrate

# Collect static files
python manage.py collectstatic --noinput --clear

# Start server
gunicorn atlasdocks.wsgi:application --bind 0.0.0.0:$PORT --timeout 300