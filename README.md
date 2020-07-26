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

### Usage

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
<%= javascript_include_tag '/snowpacks/packs/application' %>
<%= stylesheet_snowpack_tag '/snowpacks/stylesheets/index' %>
```

### Configuration

After running generator, the configuration file can be found in
`config/initializers/snowpacker.rb`

In addition, related `snowpack.config.js`, `babel.config.js`,
`.browserslistrc`, and `postcss.config.js` can all be found in the
`config/snowpacker` directory.

## Changelog

See [CHANGELOG.md](https://github.com/ParamagicDev/snowpacker/blob/master/CHANGELOG.md)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ParamagicDev/snowpacker.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
