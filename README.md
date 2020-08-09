# Snowpacker

## WORK IN PROGRESS

Please note, that this project is still in it's infancy. Feel free to
file bug reports and issues.

[![Gem Version](https://badge.fury.io/rb/snowpacker.svg)](https://badge.fury.io/rb/snowpacker)

[![Maintainability](https://api.codeclimate.com/v1/badges/b88ac1a56d868d4f23d5/maintainability)](https://codeclimate.com/github/ParamagicDev/snowpacker/maintainability)

This gem integrates the [snowpack](https://snowpack.dev/) JS module bundler into
your Rails / Ruby application. It is inspired by gems such as
[breakfast](https://github.com/devlocker/breakfast) /
[webpacker](https://github.com/rails/webpacker) started as a fork of
[parcel-rails](https://github.com/michaldarda/parcel-rails).

This is not meant to be a 1:1 replacement of Webpacker. Snowpacker is
actually just a wrapper around Snowpack using Rake and as a result can
be used without Rails.

## How is Snowpacker different?

Snowpacker uses the native ESM module spec. ESM Modules are fast,
lightweight, and natively supported by all newer browsers ("evergreen browsers")
For more reading on ESM modules, check out this link:

[TODO](TODO)

Snowpacker is also Rails agnostic. It can be used in conjunction with
Rails and provides helper methods, but Rails is not required.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'snowpacker', '~> 0.0.4.alpha1'
```

### With Rails

```bash
rails snowpacker:init
```

Which will install your yarn packages, create an initializer file, and
add config files.

#### Tasks

```bash
rails snowpacker:dev # starts a dev server
rails snowpacker:build # builds for production

rails assets:precompile # will build snowpacker and asset pipeline
```

#### New Rails app

When working with a new Rails app, it is important to switch any webpack
`require` statements to ESM-based `import`

With a new app you will have to change 2 files to achieve the same
result as Webpacker. The 2 files are
`app/javascript/packs/application.js` and the other is
`app/javascript/channels/index.js`

```diff
// app/javascript/packs/application.js

- // Webpack
- require("@rails/ujs").start()
- require("turbolinks").start()
- require("@rails/activestorage").start()
- require("channels")
+
+ // https://www.skypack.dev/ to find packages
+ import "https://cdn.skypack.dev/@rails/ujs" // Autostarts
+ import Turbolinks from "https://cdn.skypack.dev/turbolinks"
+ import ActiveStorage from "https://cdn.skypack.dev/@rails/activestorage"
+ import "../channels"

+ Turbolinks.start()
+ ActiveStorage.start()
```

```diff
// app/javascript/channels/index.js

// Load all the channels within this directory and all subdirectories.
// Channel files must be named *_channel.js.

- // const channels = require.context('.', true, /_channel\.js$/)
- // channels.keys().forEach(channels)
+ // Channels must be manually imported via `import Channel from
"<path>"`
```

Instead, now you must manually load each channels. Currently,
`require.context()` is not supported by Snowpack. It is a webpack
specific function. (There is a plugin in the works with Snowpack to
implement a plugin which does the same thing)

## File Structure

Given the below file structure and a default configuration:

```yaml
app:
├── snowpacker:
│   ├── assets:
│   ├── channels:
│   ├── packs:
│   └── stylesheets:
```

When building for production, it will output the following:

```yaml
├── public:
│   └── snowpacks:
│       ├── assets:
│       ├── channels:
│       ├── packs:
│       ├── __snowpack__:
│       ├── stylesheets:
│       └── web_modules:
```

## Including in views

Use Rails generic helpers to include assets in your views

```ruby
<%= stylesheet_link_tag '/snowpacks/stylesheets/index', media: 'all',
'data-turbolinks-track': 'reload' %>

<%= javascript_include_tag '/snowpacks/packs/application',
'data-turbolinks-track': 'reload', type: "module" %>
```

This assumes you are using the default configuration.

Make sure to use `type: "module"` for all javascript scripts, otherwise,
snowpack will not work properly.

## Configuration

After running generator, the configuration file can be found in
`config/initializers/snowpacker.rb`

In addition, all related `snowpack.config.js`, `babel.config.js`, and
`postcss.config.js` can all be found in the `config/snowpacker`
directory.

## Production

Gem hooks up to the `rails assets:precompile` and `rails
assets:clobber`, so no special setup is required.

You can start snowpacker's compilation process manually by running

```bash
rails snowpacker:compile

# OR

rails snowpacker:build
```


## Examples

Examples can be found in the [/examples](/examples) directory.

## Converting from Webpack to Snowpack

- Snowpack (as far as I'm aware) does not support the `require.context()`
so you will have to manually `register` your Stimulus Controllers and
your Websocket Channels.

- Any require statements should be rewritten to import statements.
Alternatively, you could add a polyfill-plugin to snowpack to fix this
issue as well.

## Issues

Not all packages may be compatible with Snowpack. Please check
[skypack.dev](https://skypack.dev) for ESM-compatible packages.

## Changelog

See [CHANGELOG.md](https://github.com/ParamagicDev/snowpacker/blob/master/CHANGELOG.md)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ParamagicDev/snowpacker.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
