#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE DATABASE parking-api_development;
    CREATE DATABASE parking-api_test;
    CREATE DATABASE parking-api_production;
EOSQL
