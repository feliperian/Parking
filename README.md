# Sample Parking API

Simple parking control design according to mLabs [backend test](https://github.com/mlabssoftware/mlabs-teste/blob/master/back-end.md).

## Features
- Check in, check out and pay
- Validate payment to sign out
- Show history by plate

## Requirements
- [Docker](https://docs.docker.com/) 19.03.0+
- [Docker Compose](https://docs.docker.com/compose/) 1.24.1+
- [PostgreSQL](https://www.postgresql.org/) 9.2+

## About
This is a project built with:
- [Ruby](https://www.ruby-lang.org/) 2.6.5
- [Rails](https://rubyonrails.org/) 5.2.3

## Environments

```
# Use development for the developer server
RAILS_ENV: production

# PostgreSQL Environments
PARKINGAPI_DATABASE_USERNAME: postgres
PARKINGAPI_DATABASE_PASSWORD: postgres
PARKINGAPI_DATABASE_HOST: db
PARKINGAPI_DATABASE_PORT: 5432
```

## Development

Start server:

```docker-compose up```

Running tests:

```sudo docker-compose run parking env RAILS_ENV=test bundle exec rspec```

## API Documentation

#### GET /parking

List all registry of the parking
```[{ id: 1, plate: 'OZY-0666', time: '5 minutes', paid: false, left: false }]```

#### POST /parking
When sending an valid plate

```{ plate: 'OZY-0666' }```

Receive the plate registry on the parking

```{ id: 1, time: 'less than a minute', paid: false, left: false }```

#### PUT /parking/:id/pay
Pay off parking

```{ id: 1, time: '4 minutes', paid: true, left: false }```

#### PUT /parking/:id/out
Get out of the parking

```{ id: 1, time: '5 minutes', paid: true, left: true }```

#### GET /parking/:plate
History of the plate

```[{ id: 1, time: '5 minutes', paid: true, left: true }]```
