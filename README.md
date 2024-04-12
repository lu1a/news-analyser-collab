# news-analyser-collab
A group can log in, receive a DB table's worth of news data (from 3rd party), and make analyses together on this web app.

## TODO
- database tables for news articles from 3rd party, cases (outputs based on a handful of articles), notes (related to articles), article tags, users
- login functionality (probably SSO)
- UI to show articles and tag them
- UI to create cases and pull in related articles, add notes, etc.
- optional: code for exporting cases (PDF? HTML?)
- optional: code for importing more 3rd party news data (from JSON? CSV?)

## Use case
Say I have an org whose job it is to pump out a bunch of analyses based on their political and security expertise - and we already have news data streaming in every so often from 3rd party sources. We would like a handy way to collaborate on "cases" (analyses, articles, not sure what to call the output), so that reading the data and then creating these outputs aren't done in random places that require switching tabs all the time and getting lost in other tools.

## Setup & development
### Database
You'll need to source a postgres database from somewhere.

For example, you could run
```bash
docker run --name some-postgres -e POSTGRES_PASSWORD=mysecretpassword -d postgres
```

Fill out a new file `.env` according to the fields in the `.env.example` file.
Install sql-migrate with your favourite package manager.

Then run the command
```bash
export $(grep -v '^#' .env | xargs) && sql-migrate up
```