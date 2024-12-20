'use strict';

const EmberApp = require('ember-cli/lib/broccoli/ember-app');

// const nodeSass = require('node-sass');
const environment = process.env.EMBER_ENV;
const IS_PROD = environment === 'production';
const IS_TEST = environment === 'test';

module.exports = function (defaults) {
  const app = new EmberApp(defaults, {
    // Add options here
  });

  // Import node_modules
  app.import('node_modules/bootstrap/dist/js/bootstrap.bundle.min.js');
  app.import('node_modules/bootstrap-icons/font/fonts/bootstrap-icons.woff', {
    destDir: 'assets/fonts',
  });
  app.import('node_modules/bootstrap-icons/font/fonts/bootstrap-icons.woff2', {
    destDir: 'assets/fonts',
  });

  return app.toTree();
};
