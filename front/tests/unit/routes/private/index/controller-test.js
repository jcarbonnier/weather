import { module, test } from 'qunit';
import { setupTest } from 'front/tests/helpers';

module('Unit | Controller | private/index', function (hooks) {
  setupTest(hooks);

  // TODO: Replace this with your real tests.
  test('it exists', function (assert) {
    let controller = this.owner.lookup('controller:private/index');
    assert.ok(controller);
  });
});
