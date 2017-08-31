# health-check

  

## To start the application:

`foreman start` 
or

- bundle exec sidekiq -C ../lib/sidekiq-worker -q check -v

## To open the Application:

Based on the app server used, `http://localhost:<port-number>` to open the app.


## Project Features

1. CRUD Operations
2. Sidekiq Job getting ON 
3. Pinging on regular intervals and emailing when the server goes down

## Steps

I have hosted the latest code on an Vultr instance. 

## Installation

These instructions will help setup the project locally.

1. Clone the repository

`git clone https://github.com/neha9t/health-check`

2. Follow the instructions [here](https://rvm.io/rvm/install) to install RVM. Make sure to source rvm as mentioned at the end of the installation instructions.

3. Install Ruby-2.4.0 using `rvm install ruby-2.4.0`

4. Install bundler using `gem install bundler`.

5. Redis : 
         - OSX : brew install redis
         - Ubuntu : https://redis.io/topics/quickstart

7. `cd` into the project directory and run `bundle install`.

8. Setup the database and run migrations.

* Go to config/database.yml and change your `username` and `password` to your SQLite credentials so that the app can access the database.

* Run `rake db:create`.

* Run `rake db:migrate`.

For production run `RAILS_ENV=production rake db:create db:migrate`

9. Based on the app server used, `http://localhost:<port-number>` to open the app.

10. Run 'redis-server'

11. Run  Sidekiq : ' bundle exec sidekiq -C ../lib/sidekiq-worker -q check -v'