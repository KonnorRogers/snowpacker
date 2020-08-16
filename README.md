# Snowpacker

## WORK IN PROGRESS

Please note, that this project is still in it's infancy. Feel free to
file bug reports, issues, and feature requests.

[![Gem Version](https://badge.fury.io/rb/snowpacker.svg)](https://badge.fury.io/rb/snowpacker)

[![Maintainability](https://api.codeclimate.com/v1/badges/b88ac1a56d868d4f23d5/maintainability)](https://codeclimate.com/github/ParamagicDev/snowpacker/maintainability)

This gem integrates the [snowpack](https://snowpack.dev/) JS module bundler into
your Rails / Ruby application. It is inspired by gems such as
[breakfast](https://github.com/devlocker/breakfast) /
[webpacker](https://github.com/rails/webpacker) and this project started
as a fork of
[parcel-rails](https://github.com/michaldarda/parcel-rails).

This is not meant to be a 1:1 replacement of Webpacker. Snowpacker is
actually just a wrapper around Snowpack using Rake and as a result can
be used without Rails with a little extra work.

## How is Snowpacker different?

Snowpacker uses the native ESM module spec. ESM Modules are fast,
lightweight, and natively supported by all newer browsers ("evergreen browsers")
For more reading on ESM modules, check out this link:

[https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Modules](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Modules)

Snowpacker is also unbundled during development to eliminate compilation
times and then is bundled in the final build process due to waterfall
network requests that still cause some issues in production.

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
rails snowpacker:build # builds for production (is hooked onto
precompile)
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
+ import "@rails/ujs" // Autostarts
+ import Turbolinks from "turbolinks"
+ import ActiveStorage from "@rails/activestorage"
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
+ // require.context() is currently unsupported
+ import ChannelName from "./<channel_path>"
```

## File Structure

Snowpacker makes some assumptions about your file paths to provide
helper methods.

```bash
tree -L 2 app/snowpacker

app/snowpacker/
├── assets/
│   └── picture.png
├── channels/
│   ├── consumer.js
│   └── index.js
├── packs/
│   └── application.js
├── javascript/
│   └── index.js
└── stylesheets/
    └── index.css
```

Which upon build will output to look like this:

```bash
tree -L 1 public/snowpacks

public/snowpacks/
├── assets/
├── channels/
├── packs/
├── javascript/
├── __snowpack__/
├── stylesheets/
└── web_modules/

```

### Generic Helper

`<%= snowpacker_path %>` will return the value of
`Snowpacker.config.output_path`


### Assets

Assets can be accessed via `<%= snowpacker_assets_path %>` and accepts all
the same params as [#asset_path](https://api.rubyonrails.org/classes/ActionView/Helpers/AssetUrlHelper.html#method-i-asset_path)

### Channels

Channels have no special helper.

### Packs

Packs can be accessed via:

`<%= snowpacker_pack_tag %>` and works the same as
[#javascript_include_tag](https://api.rubyonrails.org/classes/ActionView/Helpers/AssetTagHelper.html#method-i-javascript_include_tag)

### Javascript

Javascript has no special helper.

This is the recommended file structure. `packs` are your "entrypoints"
and where files get bundled to.

### Stylesheets

Stylesheets can be accessed via:

`<%= snowpacker_stylesheet_link_tag %>` and works just like
[#stylesheet_link_tag](https://api.rubyonrails.org/classes/ActionView/Helpers/AssetTagHelper.html#method-i-stylesheet_link_tag). I recommend importing your css in your `packs` file if you plan on changing it to support HMR.

### HMR

To enable HMR in your `<head>` of your document simply put:

`<%= snowpacker_hmr_tag %>`

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

- As a result of not having `require.context()` supported, I have added a package called
[@rollup/plugin-dynamic-import-vars](https://github.com/rollup/plugins/tree/master/packages/dynamic-import-vars)
which works very similarly.

- Any require statements should be rewritten to import statements.
Alternatively, you could add a polyfill-plugin to snowpack to fix this
issue as well.

[https://www.snowpack.dev/#node-built-in-could-not-be-resolved](https://www.snowpack.dev/#node-built-in-could-not-be-resolved)

## Issues

Not all packages may be compatible with Snowpack. Please check
[skypack.dev](https://skypack.dev) for ESM-compatible packages.

## Changelog

See [CHANGELOG.md](https://github.com/ParamagicDev/snowpacker/blob/master/CHANGELOG.md)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ParamagicDev/snowpacker.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Roadmap

[ ] Add default file structure with init
[ ] Add a bundler for production
[ ] Support require.context

Support is similar, but not the same [https://github.com/rollup/plugins/tree/master/packages/dynamic-import-vars](https://github.com/rollup/plugins/tree/master/packages/dynamic-import-vars)

[ ] Add documentation on Stimulus

[https://github.com/lightster/rollup-plugin-stimulus](https://github.com/lightster/rollup-plugin-stimulus)
