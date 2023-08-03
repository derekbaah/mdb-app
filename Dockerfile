FROM ruby:2.7.4
WORKDIR /app
RUN apt-get update -qq && apt-get install -y nodejs sqlite3
RUN gem install rails -v '6.1.7'
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . .
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]