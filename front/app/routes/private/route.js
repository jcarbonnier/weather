import Route from '@ember/routing/route';

import { inject as service } from '@ember/service';

export default class PrivateRoute extends Route {
  @service session;

  beforeModel(transition) {
    super.beforeModel(...arguments);
    return this.session.requireAuthentication(transition, 'session.login');
  }

  // model() {
  //   return this.store.findRecord('user', this.session.currentUser.id);
  // }

  // afterModel(result) {
  //   console.log("Found user", result.weatherLocations);
  // }
}
