#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE DATABASE parkingapi_development;
    GRANT ALL PRIVILEGES ON DATABASE parkingapi_development TO postgres;
    CREATE DATABASE parkingapi_test;
    GRANT ALL PRIVILEGES ON DATABASE parkingapi_test TO postgres;
    CREATE DATABASE parkingapi_production;
    GRANT ALL PRIVILEGES ON DATABASE parkingapi_production TO postgres;
EOSQL
