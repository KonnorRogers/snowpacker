// Load all the channels within this directory and all subdirectories.
// Channel files must be named *_channel.js.

// WEbpack only
const channels = require.context('.', true, /_channel\.js$/)
channels.keys().forEach(channels)
console.log(channels)
