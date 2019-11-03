module.exports = {
  test: /\.erb$/,
  enforce: 'pre',
  exclude: /node_modules/,
  use: [{
    loader: 'rails-erb-loader',
    options: {
      runner: (/^win/.test(process.platform) ? 'ruby ' : '') + 'bin/rails runner'
      // runner: 'bundle exec bin/rails runner'
      // runner: 'bin/rails runner'
      // runner: 'DISABLE_SPRING=true bin/rails runner'
    }
  }]
}
