import ESASession from 'ember-simple-auth/services/session';

import { inject as service } from '@ember/service';
import { tracked } from '@glimmer/tracking';
import { isEmpty } from '@ember/utils';

export default class SessionService extends ESASession {
  // --------------------------------------------------
  // SERVICES
  // --------------------------------------------------
  @service store;
  @service router;

  // --------------------------------------------------
  // TRACKED
  // --------------------------------------------------
  @tracked currentUser;

  // == Load current user when session is authenticated
  async loadCurrentUser() {
    console.debug('[service][session] loadCurrentUser', this.isAuthenticated);
    if (this.isAuthenticated && isEmpty(this.currentUser)) {
      return this.store
        .findRecord('user', this.currentUserId, { include: ['weather_locations'] })
        .then((user) => {
          this.currentUser = user;
        });
    }
  }

  /**
   * Handle authentication hook
   */
  async handleAuthentication() {
    // Empty string => base Application route
    super.handleAuthentication('');
    try {
      console.debug('[service][session] handleAuthentication');
      await this.loadCurrentUser();
    } catch (error) {
      console.error('[service][session] handleAuthentication error', error);
    }
  }

  /**
   * Need to handle invalidation because Env.rootURL is different
   * from router.rootURL (redefined in router.init method)
   */
  handleInvalidation() {
    super.handleInvalidation(this.router.rootURL);
  }

  /**
   * Access token
   */
  get currentToken() {
    return (
      this.data.authenticated.token || this.data.authenticated.access_token
    );
  }

  /**
   * Access token
   */
  get currentUserId() {
    return this.data.authenticated.id;
  }
}
