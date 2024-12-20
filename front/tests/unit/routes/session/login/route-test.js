import { module, test } from 'qunit';
import { setupTest } from 'front/tests/helpers';

module('Unit | Route | session/login', function (hooks) {
  setupTest(hooks);

  test('it exists', function (assert) {
    let route = this.owner.lookup('route:session/login');
    assert.ok(route);
  });
});
