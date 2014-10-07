# Takeaways App

This app helps FastSigns Durango track takeaways at it's various locations throughout town. It's built by the students at Durango Ruby School.

Heroku app location: http://takeaways.herokuapp.com/

You can view project notifications in Durango Ruby School's Hipchat.

## Dependencies

* Postgresql

## Setup Instructions

1. `cp config/database-example.yml config/database.yml`
2. Make any changes in the database.yml to have it work with your system.
3. `cp .env-example .env`
4. Make the appropriate environment variable changes if needed
5. `rake db:setup` to set up your database
6. `rake` to run the specs

## Environment Variables

The application depends on the following environment variables. These can be set in .env for development and test

```
SECRET_KEY_BASE= <Random string to used to generate session keys. See config/secrets.yml>
HONEYBADGER_API_KEY = Honeybadger api key
```

## Contributing

1. Make a new branch (`git checkout -b <branch name>`)
2. `git status` to make sure you're on a branch
3. Make your changes for this specific feature. You can do multiple commits.
4. Push your branch to github (`git push origin <branch name>`)
5. Create a pull request
