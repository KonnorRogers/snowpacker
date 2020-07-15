# parcel-rails

[![Gem Version](https://badge.fury.io/rb/parcel-rails.svg)](https://badge.fury.io/rb/parcel-rails)
[![Maintainability](https://api.codeclimate.com/v1/badges/4b0a3f36a6b1970a88e5/maintainability)](https://codeclimate.com/github/michaldarda/parcel-rails/maintainability)
[![Build Status](https://travis-ci.org/michaldarda/parcel-rails.svg?branch=master)](https://travis-ci.org/michaldarda/parcel-rails)

Gem integrates [parcel](https://parceljs.org/) JS module bundler into your Rails application. It is inspired by gems such as
[breakfast](https://github.com/devlocker/breakfast) or [webpacker](https://github.com/rails/webpacker).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'parcel-rails'
```

Then run

    $ bin/rails g parcel

### Development

Currently `parcel` is not integrated with `rails s` so you need a process manager like [foreman]() to run both `rails s` and `parcel`.

Create `Procfile.dev`, with the following content:

```
web: bin/rails s
parcel: bin/rails parcel:serve
```

Then run `foreman start -f Procfile.dev`

### Production

Gem hooks up to the `assets:precompile` and `assets:clobber`, so no special setup is required.

You can start parcel's compilation process manually by running

    rake parcel:compile

### Including in views

Use Rails generic helpers to include assets in your views

    javascript_include_tag '/parcels/application'
    stylesheet_link_tag '/parcels/application'

### Configuration

After running generator, configuration can be found in config/initializers/parcel.rb.

	config.parcel.entry_points = %w(app/javascript/application.js)
	config.parcel.destination = 'public/parcels'

#### Warning

Currently only single entry point is supported, it is limitation coming from Parcel itself and not the gem.

## Changelog

See [CHANGELOG.md](https://github.com/michaldarda/parcel-rails/blob/master/CHANGELOG.md)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/michaldarda/parcel-rails. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the *parcel-rails* project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/michaldarda/parcel-rails/blob/master/CODE_OF_CONDUCT.md).

