# RailsOnDocker

__For more detailed information go to [docker documentation](https://docs.docker.com/compose/rails/)__

## How to use

_Obs. After any command that creates or modifies files run:_
```
sudo chown -R $(id -u):$(id -g) myapp/
```

Change db.env, so it contains the username and password that postgres will use.


To generate Rails app run:
```
sudo docker-compose run web rails new . --force --no-deps --database=postgresql
```

After any modification in the Gemfile(like after running the last command) or in the Dockerfile run:
```
sudo docker-compose build
```

Change config/database.yml to(_Change username and password  name accordingly to db.env_):
```
default: &default
	adapter: postgresql
	encoding: unicode
	host: db
	username: Username
	password: Password
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

__If *"myapp/config/webpacker.yml"* is not created after the rails new command run:__
```
curl https://bit.ly/2q8Dgo4 > myapp/config/webpacker.yml
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
