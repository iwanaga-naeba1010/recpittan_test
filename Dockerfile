FROM ruby:3.0.3

RUN dpkg --add-architecture amd64
RUN dpkg --print-foreign-architectures

# Using Node.js v14.x(LTS)
RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash -

# Add packages
RUN apt-get update && apt-get install -y git nodejs vim graphviz

# Add yarnpkg for assets:precompile
RUN npm install -g yarn webpack-dev-server

WORKDIR /app
