import FormInput from 'front/components/form/input';

import { guidFor } from '@ember/object/internals';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

export default class FormInputFloatingDelayedComponent extends FormInput {
  @tracked tempValue = this.args.value;

  uid = guidFor(this);
  timerDuration = this.args.timerDuration || 500;
  timeout = null;

  @action
  handleKeyUp(event) {
    clearTimeout(this.timeout);
    this.timeout = setTimeout(() => {
      this.onChange(event.target.value);
    }, this.timerDuration);
  }

  onChange(value) {
    if (this.args.onChange) {
      this.args.onChange(value);
    } else {
      console.log('[Input component] error: @onChange must be implemented');
    }
  }
}
