const rewireReactHotLoader = require('react-app-rewire-hot-loader')
const path = require('path');

module.exports = function override(config, env) {
  config.resolve = {
    ...config.resolve,
    alias: {
      ...config.alias,
      "@api": path.resolve(__dirname, "src/api"),
      "@components": path.resolve(__dirname, "src/components"),
      "@constants": path.resolve(__dirname, "src/constants"),
      "@store": path.resolve(__dirname, "./src/store"),
      "@theme": path.resolve(__dirname, "src/theme"),
    },
  };
config = rewireReactHotLoader(config, env)
return config;
};
