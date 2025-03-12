# Use the official Ruby image with a more recent version (Ruby 2.7 or 3.x)
FROM ruby:2.7

# Set the working directory in the container
WORKDIR /app

# Install nodejs (JavaScript runtime) and other dependencies
RUN apt-get update -qq && apt-get install -y nodejs

# Install dependencies and Bundler
RUN gem install bundler -v 2.2.17 # Install a compatible Bundler version for Middleman
RUN gem install webrick # Ensure the required web server is available (if needed by your version)

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install the gems specified in Gemfile
RUN bundle install

# Copy the rest of the application code into the container
COPY . .

# Expose port 4567 to access the Middleman server
EXPOSE 4567

# Command to start the Middleman server
CMD ["bundle", "exec", "middleman", "server"]
