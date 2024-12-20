import JSONAPIAdapter from '@ember-data/adapter/json-api';

import Env from 'front/config/environment';

import { underscore } from '@ember/string';
import { pluralize } from 'ember-inflector';
import { inject as service } from '@ember/service';

export default class ApplicationAdapter extends JSONAPIAdapter {
  // --------------------------------------------------
  // SERVICES
  // --------------------------------------------------
  @service session;

  // --------------------------------------------------
  // ATTRIBUTES AND METHODS
  // --------------------------------------------------
  namespace = Env.adapterNamespace;
  coalesceFindRequests = true;

  /**
   * Format type for API
   *
   * @param {*} type
   * @returns
   */
  pathForType(type) {
    return pluralize(underscore(type));
  }

  /**
   * Adding Authorization header in requests
   */
  get headers() {
    let headers = {};
    if (this.session.isAuthenticated) {
      headers['Authorization'] = `Bearer ${this.session.currentToken}`;
    }
    return headers;
  }

  /**
   * Handle response, overriding deprecated method from DataAdapterMixin
   *
   * @param {*} status
   * @param {*} headers
   * @param {*} payload
   * @param {*} requestData
   */
  handleResponse(status) {
    if (status === 401 && this.session.isAuthenticated) {
      this.session.invalidate();
    }
    return super.handleResponse(...arguments);
  }
}
