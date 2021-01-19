FROM ruby:2.7.2-buster
LABEL author="Josh Tune <josh@eitacode.com>"

##
# Install system packages

RUN apt-get update -qq && apt-get install -qq -y --no-install-recommends \
  imagemagick \
  nano \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get clean

##
# Install system gems

RUN gem install bundler && bundle config set system 'true'

##
# Build the Rails application

WORKDIR /srv/app
COPY Gemfile* ./
RUN bundle install -j4

COPY . .

EXPOSE 3000

CMD ["rails", "s", "-b", "0.0.0.0"]
