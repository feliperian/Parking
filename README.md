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
This is a project built with Rails.

## Development

Start server:

```docker-compose up```

Running tests:

```docker-compose run parking bundle exec rspec```
