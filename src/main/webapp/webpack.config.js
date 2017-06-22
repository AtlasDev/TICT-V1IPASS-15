var webpack = require('webpack');

module.exports = {
  entry: {
    'index.js': './src/index.ts',
    'sw.js': './src/sw.ts'
  },
  output: {
    path: __dirname + '/dist/',
    publicPath: 'dist/',
    filename: '[name]'
  },
  resolve: {
    extensions: ['.ts', '.js', '.css']
  },
  node: {
    __dirname: false,
    require: false,
  },
  module: {
    rules: [{
      test: /\.ts$/,
      exclude: /node_modules|vue\/src/,
      loader: 'ts-loader',
      options: {
        appendTsSuffixTo: [/\.vue$/]
      }
    }, {
      test: /\.vue$/,
      loader: 'vue-loader',
      options: {
        esModule: true
      }
		}, {
      test: /\.css$/,
      loaders: [{
        loader: "vue-style-loader"
      }, {
        loader: "css-loader"
      }]
    }, {
			test: /\.(gif|png|jpe?g|svg)$/i,
			loaders: [{
        loader: 'file-loader',
        options: {
          name: 'img/[name].[ext]'
        }
      }, {
        loader: 'image-webpack-loader',
        options: {
          mozjpeg: {
            progressive: true,
          },
          gifsicle: {
            interlaced: true,
          },
          optipng: {
            optimizationLevel: 7,
          }
        }
      }]
		}]
  },
  devtool: 'source-map',
	devServer: {
    compress: true,
    disableHostCheck: true
	}
};
