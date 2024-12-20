import EmberRouter from '@ember/routing/router';
import config from 'front/config/environment';

export default class Router extends EmberRouter {
  location = config.locationType;
  rootURL = config.rootURL;
}

Router.map(function () {
  this.route('private', { path: '/' }, function () {
    this.route('weather-locations', function () {
      this.route('show', { path: ':id' });
    });
  });
  this.route('session', function () {
    this.route('login');
  });
});
