import Route from '@ember/routing/route';

import { inject as service } from '@ember/service';

export default class PrivateIndexRoute extends Route {
  // ==================================================
  // Services
  // ==================================================
  @service store;

  // ==================================================
  // Query params
  // ==================================================
  queryParams = {
    // filters
    name: { refreshModel: true },
  };

  // ==================================================
  // Handlers
  // ==================================================
  model(params) {
    return this.store.query('location', {
      filter: params,
    });
  }

  afterMode() {
    console.log(
      'User weather locations',
      this.session.currentUser.weatherLocations.length,
    );
  }
}
