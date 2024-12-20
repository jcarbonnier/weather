import Route from '@ember/routing/route';

import { hash } from 'rsvp';
import { inject as service } from '@ember/service';

export default class SessionLoginRoute extends Route {
  // --------------------------------------------------
  // SERVICES
  // --------------------------------------------------
  @service store;
  @service session;
  @service router;

  // ==================================================
  // Query params
  // ==================================================
  queryParams = {
    // error message from provider
    error: { refreshModel: false },
  };

  // --------------------------------------------------
  // HANDLERS
  // --------------------------------------------------
  beforeModel(/*transition*/) {
    super.beforeModel(...arguments);
    this.session.prohibitAuthentication('private');
  }

  model() {
    return {
      errors: {},
      user: this.store.createRecord('user'),
    };
  }
}
