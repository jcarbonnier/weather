import Route from '@ember/routing/route';

import { action } from '@ember/object';
import { inject as service } from '@ember/service';

export default class ApplicationRoute extends Route {
  // --------------------------------------------------
  // SERVICES
  // --------------------------------------------------
  @service intl;
  @service notify;
  @service moment;
  @service session;

  // --------------------------------------------------
  // HANDLERS
  // --------------------------------------------------
  beforeModel() {
    super.beforeModel(...arguments);
    // Setup intl locale
    this.intl.setLocale('fr');
    // Setup Moment locale
    this.moment.setLocale('fr');
    // this.moment.tz.setDefault("Europe/Paris");
    // Setup session
    return this.session.setup().then(() => {
      // Load user if already authenticated
      return this.session.loadCurrentUser();
    });
  }

  setupController(controller) {
    controller.session = this.session;
  }

  // --------------------------------------------------
  // ACTIONS
  // --------------------------------------------------
  /**
   * Catch API invalid responses (ex. 500)
   *
   * @param {*} reason
   */
  @action
  error(reason) {
    console.error('[Application][error] Response error', reason);
    this.notify.toast(this.intl.t('notifications.failure.main'), 'danger');

    // Can transition to another route here, e.g.
    // this.router.transitionTo('index');

    // Uncomment the line below to bubble this error event:
    // return true;
  }

  @action
  invalidateSession() {
    this.session.invalidate();
  }
}
