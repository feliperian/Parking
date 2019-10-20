#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE DATABASE parkingapi_development;
    CREATE DATABASE parkingapi_test;
    CREATE DATABASE parkingapi_production;
    GRANT ALL PRIVILEGES ON DATABASE parkingapi_development TO postgres;
    GRANT ALL PRIVILEGES ON DATABASE parkingapi_test TO postgres;
    GRANT ALL PRIVILEGES ON DATABASE parkingapi_production TO postgres;
EOSQL
