# Takeaways App

This app helps FastSigns Durango track takeaways at it's various locations throughout town. It's built by the students at Durango Ruby School.

## Dependencies

* Postgresql

## Setup Instructions

1. `cp config/database-example.yml config/database.yml`
2. Make any changes in the database.yml to have it work with your system.
3. `cp .env-example .env`
4. Make the appropriate environment variable changes if needed
5. `rake db:setup` to set up your database

## Environment Variables

The application depends on the following environment variables. These can be set in .env for development and test

```
SECRET_KEY_BASE= <Random string to used to generate session keys. See config/secrets.yml>
```
