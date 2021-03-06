FROM ruby

RUN apt-get update -qq
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" >> /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq
RUN apt-get install -y nodejs postgresql-client yarn

RUN mkdir /myapp
WORKDIR /myapp
COPY /myapp/Gemfile /myapp/Gemfile
COPY /myapp/Gemfile.lock /myapp/Gemfile.lock

RUN bundle install
COPY ./myapp /myapp

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]


EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
