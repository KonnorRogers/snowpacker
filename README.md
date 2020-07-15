# Snowpacker

## WORK IN PROGRESS

Progress can be seen on the `development` branch. Right now, this is a just a fork.

[![Gem Version](https://badge.fury.io/rb/parcel-rails.svg)](https://badge.fury.io/rb/parcel-rails)
[![Maintainability](https://api.codeclimate.com/v1/badges/4b0a3f36a6b1970a88e5/maintainability)](https://codeclimate.com/github/ParamagicDev/snowpacker/maintainability)

Gem integrates [snowpack](https://snowpack.dev/) JS module bundler into
your Rails application. It is inspired by gems such as
[breakfast](https://github.com/devlocker/breakfast) /
[webpacker](https://github.com/rails/webpacker) and is a fork off of
[parcel-rails](https://github.com/michaldarda/parcel-rails)

This is not meant to be a 1:1 replacement of Webpacker.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'snowpacker'
```

Then run

    $ bin/rails g snowpacker

### Development

Currently `snowpacker` is not integrated with `rails s` so you need a process manager like [foreman]() to run both `rails s` and `parcel`.

Create `Procfile.dev`, with the following content:

```
web: bin/rails s
parcel: bin/rails parcel:serve
```

Then run `foreman start -f Procfile.dev`

### Production

Gem hooks up to the `assets:precompile` and `assets:clobber`, so no special setup is required.

You can start snowpacker's compilation process manually by running

    rake snowpacker:compile

### Including in views

Use Rails generic helpers to include assets in your views

    javascript_include_tag '/snowpacks/application'
    stylesheet_link_tag '/snowpacks/application'

### Configuration

After running generator, configuration can be found in config/initializers/parcel.rb.

	config.parcel.entry_points = %w(app/javascript/application.js)
	config.parcel.destination = 'public/snowpacks'

#### Warning

Currently only single entry point is supported, it is limitation coming from Parcel itself and not the gem.

## Changelog

See [CHANGELOG.md](https://github.com/ParamagicDev/snowpacker/blob/master/CHANGELOG.md)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ParamagicDev/snowpacker.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
