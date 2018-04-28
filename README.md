# ASU CSE 412 Project Phase 3

## Getting Ruby 2.5.1
In order to be sure that this project works correctly, Ruby >= 2.5.1 should be used. You can install Ruby 2.5.1 using RVM. To install RVM and Ruby 2.5.1, run the following commands:
```
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
\curl -sSL https://get.rvm.io | bash -s stable --ruby=2.5.1
```

Ruby 2.5.1 should now be installed. You can confirm that you are using the correct version of ruby by running:
```
$ ruby --version
ruby 2.5.1p57 (2018-03-29 revision 63029) [x86_64-linux]
```
and making sure the version is 2.5.1.

## Loading the Database
To import the database, you must have a postgresql server already installed and running.
You must also have a user named cse412 with password 'cse412', and a database named 'cse412'. You can do the setup by running the following commands from the postgresql console. First, start the postgresql console (you can replace the postgres user with any that has the proper permissions):
```
psql -U postgres
```

Next, create the cse412 user:
```
CREATE USER cse412 WITH PASSWORD 'cse412';
```

Next create the database:
```
CREATE DATABASE cse412;
```

With the above setup done, you can run:
```
psql -U cse412 -f dbexport.pgsql
```

## How to Run
**Note: This was only tested with Ruby 2.5.1, any other versions may have issues**

Ruby on Rails requires a javascript runtime (like [nodejs](https://nodejs.org/en/)) to be installed, so before running the following commands, you must have a javascript runtime installed.

Install Bundler:
```
gem install bundler
```

Install all other dependencies:
```
bundle install
```

Run the server:
```
rails s
```

You can now access the website by going to `http://localhost:3000`
