FROM ruby:2.6-alpine3.11 as builder

# Install system dependencies & clean them up
RUN apk add --no-cache \
   nodejs-dev yarn bash \
   tzdata build-base libffi-dev \
   curl git vim \
   libnotify-dev

FROM builder as snowpacker-app

# This is to fix an issue on Linux with permissions issues
ARG USER_ID=${USER_ID:-1000}
ARG GROUP_ID=${GROUP_ID:-1000}
ARG DOCKER_USER=${DOCKER_USER:-user}
ARG APP_DIR=${APP_DIR:-/home/user/snowpacker}

# Create a non-root user
RUN addgroup -g $GROUP_ID -S $GROUP_ID
RUN adduser --disabled-password -G $GROUP_ID --uid $USER_ID -S $DOCKER_USER

# Create and then own the directory to fix permissions issues
RUN mkdir -p $APP_DIR
RUN chown -R $USER_ID:$GROUP_ID $APP_DIR

# Define the user running the container
USER $USER_ID:$GROUP_ID

# . now == $APP_DIR
WORKDIR $APP_DIR

RUN gem install bundler
# COPY is run as a root user, not as the USER defined above, so we must chown it
COPY --chown=$USER_ID:$GROUP_ID Gemfile* *.gemspec .git $APP_DIR/

RUN mkdir -p $APP_DIR/lib/snowpacker
COPY --chown=$USER_ID:$GROUP_ID lib/snowpacker/version.rb $APP_DIR/lib/snowpacker/version.rb
RUN bundle install
COPY . .

CMD ["bundle", "exec", "rake", "test"]
