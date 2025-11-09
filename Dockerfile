# Use prebuilt Ruby 2.4.10 image, force x86_64
FROM --platform=linux/amd64 ruby:3.2.2-bullseye

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC
ENV LANG=C.UTF-8
WORKDIR /app

# Use archive repositories for Debian Buster (oldstable)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      build-essential \
      libpq-dev \
      nodejs \
      yarn \
      imagemagick \
      curl \
      libssl-dev \
      libreadline-dev \
      zlib1g-dev \
      libffi-dev \
      git \
      ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Install Bundler compatible with Ruby 2.5.8
RUN gem install bundler -v 2.3.26

# Copy Gemfile for caching
COPY Gemfile* /app/
RUN bundle install

# Copy rest of app
COPY . /app

EXPOSE 3000
CMD ["bash"]
