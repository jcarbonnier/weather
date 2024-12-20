import { setupTest } from 'front/tests/helpers';
import { module, test } from 'qunit';

module('Unit | Model | weather forecast', function (hooks) {
  setupTest(hooks);

  // Replace this with your real tests.
  test('it exists', function (assert) {
    const store = this.owner.lookup('service:store');
    const model = store.createRecord('weather-forecast', {});
    assert.ok(model, 'model exists');
  });
});
