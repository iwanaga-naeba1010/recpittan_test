FROM ruby:3.3.6

RUN dpkg --add-architecture amd64
RUN dpkg --print-foreign-architectures

# Using Node.js v16.x(LTS)
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -

# Add packages
RUN apt-get update && apt-get install -y git nodejs vim graphviz

# Add yarnpkg for assets:precompile
RUN npm install -g yarn webpack-dev-server

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN gem install bundler --version 2.2.22 && \
    bundle config set --local path /usr/local/bundle && \
    bundle install --jobs 4

COPY package.json yarn.lock ./

RUN yarn install

