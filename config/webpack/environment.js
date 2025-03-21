const { environment } = require('@rails/webpacker')
const jquery = require('./plugins/jquery')
// jQueryとBootstapのJSを使えるように設定
const webpack = require('webpack')
environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
    Popper: 'popper.js'
  })
)
environment.plugins.prepend('jquery', jquery)
module.exports = environment

// path aliasを使うための設定
const { resolve } = require('path');
environment.config.merge({
  resolve: {
    alias: {
      '@': resolve('reactSrc'),
    },
  },
})
