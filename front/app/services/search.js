import Service from '@ember/service';

import { inject as service } from '@ember/service';

import * as Notify from 'front/services/notify';

export default class SearchService extends Service {
  // ==================================================
  // SERVICES
  // ==================================================
  @service store;
  @service notify;

  // Search resource by name
  // @param {*} modelName
  // @param {*} value
  // @returns {Promise}
  byName(modelName, value, filterOptions = {}) {
    if (value.length < 2) {
      return Promise.resolve([]);
    }
    return this.store
      .query(modelName, {
        filter: {
          name: value,
          page: 1,
          pageSize: 25,
          sort: 'name',
          ...filterOptions,
        },
      })
      .catch((reason) => {
        console.error(
          '[AdminProjectsFormController] search byName error',
          reason,
        );
        this.notify.toast('Erreur de recherche', Notify.ERROR);
      });
  }
}
