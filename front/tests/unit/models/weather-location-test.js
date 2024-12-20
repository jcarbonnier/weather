import { setupTest } from 'front/tests/helpers';
import { module, test } from 'qunit';

module('Unit | Model | weather location', function (hooks) {
  setupTest(hooks);

  // Replace this with your real tests.
  test('it exists', function (assert) {
    const store = this.owner.lookup('service:store');
    const model = store.createRecord('weather-location', {});
    assert.ok(model, 'model exists');
  });
});
