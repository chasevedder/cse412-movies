# ASU CSE 412 Project Phase 3

## Loading the Database
To import the database, you must have a postgresql server already installed and running.
You must also have a user named cse412 with password 'cse412', and a database named 'cse412'. You can do the setup by running the following commands from the postgresql console. First, start the postgresql console (you can replace the postgres user with any that has the proper permissions):
```
$ psql -U postgres
```

```
postgres=# CREATE USER cse412 WITH PASSWORD 'cse412';
```

Next create teh database:
```
postgres=# CREATE DATABASE cse412;
```

With the above setup done, you can run:
```
$ psql -U cse412 -f dbexport.pgsql
```

## How to Run
**Note: This was only tested with Ruby 2.5.1, any other versions may have issues**

Ruby on Rails requires a javascript runtime (like [nodejs](https://nodejs.org/en/)) to be installed, so before running the following commands, you must have a javascript runtime installed.

Install Bundler:
```
$ gem install bundler
```

Install all other dependencies:
```
$ bundle install
```

Run the server:
```
$ rails s
```

You can now access the website by going to `http://localhost:3000`
