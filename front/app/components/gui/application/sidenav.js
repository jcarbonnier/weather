import Component from '@glimmer/component';

import { action } from '@ember/object';
import { inject as service } from '@ember/service';

export default class GuiApplicationSidenavComponent extends Component {
  // --------------------------------------------------
  // SERVICES
  // --------------------------------------------------
  @service session;
  @service notify;
  @service intl;

  // --------------------------------------------------
  // ACTIONS
  // --------------------------------------------------
  @action
  invalidateSession() {
    this.session.invalidate();
  }
}
