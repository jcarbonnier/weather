import Service from '@ember/service';

import { inject as service } from '@ember/service';
import { isEmpty } from '@ember/utils';

export const SUCCESS = 'success';
export const ERROR = 'danger';
export const DANGER = 'danger';
export const WARNING = 'warning';

export default class NotifyService extends Service {
  // ==================================================
  // Services
  // ==================================================
  @service intl;

  // ==================================================
  // PUBLIC METHODS
  // ==================================================
  /**
   * Notification with toast
   *
   * @param {*} message
   * @param {*} state
   */
  toast(message, state) {
    var title = null;
    var toaster = document.getElementById('toaster');
    if (isEmpty(toaster)) {
      console.log('Error: toaster is empty');
      return;
    }
    toaster.classList.remove('bg-success', 'bg-danger', 'bg-warning');
    if (state === SUCCESS) {
      title = this.intl.t('notifications.success.title');
      toaster.classList.add('bg-success');
    } else if (state === WARNING) {
      title = this.intl.t('notifications.warning.title');
      toaster.classList.add('bg-warning');
    } else if (state === ERROR || state === DANGER) {
      title = this.intl.t('notifications.failure.title');
      toaster.classList.add('bg-danger');
    }
    document.getElementById('toasterTitle').innerHTML = title;
    document.getElementById('toasterBody').innerHTML = message;
    /* global bootstrap */
    var myToast = bootstrap.Toast.getOrCreateInstance(toaster);
    myToast.show();
  }
}
