# RailsOnDocker

__For more detailed information go to [docker documentation](https://docs.docker.com/compose/rails/)__

### Attention!!!

Never use a database on docker in production. A dockered database serves only for development purposes.
For more on that topic click [here.](https://myopsblog.wordpress.com/2017/02/06/why-databases-is-not-for-containers/)

## How to use

_Obs. After any command that creates or modifies files run:_
```
sudo chown -R $(id -u):$(id -g) myapp/
```

Change db.env, so it contains the username and password that postgres will use.


To generate Rails app run:
```
sudo docker-compose run web bundle install
sudo docker-compose run web rails new . --force --skip-bundle --database=postgresql
```

After any modification in the Gemfile(like after running the last command) or in the Dockerfile run:
```
sudo docker-compose build
```

Change config/database.yml to:
```
default: &default
    adapter: postgresql
    encoding: unicode
    host: db
    username: <%= ENV['POSTGRES_USER'] %>
    password: <%= ENV['POSTGRES_PASSWORD'] %>
    pool: 5

development:
    <<: *default
    database: myapp_development

test:
    <<: *default
    database: myapp_test

production:
    <<: *default
    database: myapp
```

Now boot the app with(_do this anytime you need to start the app_):
```
sudo docker-compose up
```

To create the database run(_while containers are up_):
```
sudo docker-compose run web rake db:create
```

You should be able to see the Rails welcome page by now

To safely stop the application, on the the project directory run:
```
sudo docker-compose down
```
