# Snowpacker

## WORK IN PROGRESS

Progress can be seen on the `development` branch.

[![Gem Version](https://badge.fury.io/rb/snowpacker.svg)](https://badge.fury.io/rb/snowpacker)
[![Maintainability](https://api.codeclimate.com/v1/badges/4b0a3f36a6b1970a88e5/maintainability)](https://codeclimate.com/github/ParamagicDev/snowpacker/maintainability)

This gem integrates the [snowpack](https://snowpack.dev/) JS module bundler into
your Rails application. It is inspired by gems such as
[breakfast](https://github.com/devlocker/breakfast) /
[webpacker](https://github.com/rails/webpacker) started as a fork of
[parcel-rails](https://github.com/michaldarda/parcel-rails)

This is not meant to be a 1:1 replacement of Webpacker.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'snowpacker'
```

Then run

```bash
bin/rails g snowpacker
```

### Development

Currently `snowpacker` is not integrated with `rails s` so you need a process manager like [foreman](https://github.com/ddollar/foreman) to run both `rails s` and `snowpack`.

Create `Procfile.dev`, with the following content:

```bash
web: bin/rails s
snowpacker: bin/rails snowpacker:dev
```

Then run `foreman start -f Procfile.dev`

Alternatively, you can run:

```
rails server
rails snowpacker:dev
```

in 2 different terminals.

### Production

Gem hooks up to the `assets:precompile` and `assets:clobber`, so no special setup is required.

You can start snowpacker's compilation process manually by running

```bash
rails snowpacker:compile

# OR

rails snowpacker:build
```

### Including in views

Use Rails generic helpers to include assets in your views

```ruby
<%= javascript_include_tag '/snowpacks/application' %>
<%= stylesheet_snowpack_tag '/snowpacks/application' %>
```

### Configuration

After running generator, the configuration file can be found in
`config/initializers/snowpacker.rb`

```ruby
config.snowpacker.entry_points = %w(app/javascript/snowpacks/application.js)
config.snowpacker.destination = 'snowpacks'
```

## Changelog

See [CHANGELOG.md](https://github.com/ParamagicDev/snowpacker/blob/master/CHANGELOG.md)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ParamagicDev/snowpacker.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
