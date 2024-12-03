#!/bin/bash
# Requires the database to be up
FLASK_ENV=development

POSTGRESQL_USER=myuser
POSTGRESQL_PASSWORD=mypassword
POSTGRESQL_DB=mydatabase
DATABASE_URI=postgresql://$POSTGRESQL_USER:$POSTGRESQL_PASSWORD@127.0.0.1:5432/$POSTGRESQL_DB

python manage.py
