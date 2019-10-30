# RailsOnDocker

__For more detailed information go to [docker documentation](https://docs.docker.com/compose/rails/)__

## How to use

_Obs. After any command that creates or modifies files run:_
```
sudo chown -R $(id -u):$(id -g) myapp/
```

To generate Rails app run:
```
sudo docker-compose run web rails new . --force --no-deps --database=postgresql
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
	  username: postgres
	  password:
	  pool: 5
 
 development:
	  <<: *default
	  database: myapp_development
 
 
 test:
	  <<: *default
	  database: myapp_test
```

Now boot the app with(_do this anytime you need to start the app_):
```
sudo docker-compose up
```

To create the database run(while containers are up):
```
sudo docker-compose run web rake db:create
```

You should be able to see the Rails welcome page by now

To safely stop the application, on the the project directory run:
```
sudo docker-compose down
```
