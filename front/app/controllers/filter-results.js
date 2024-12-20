import Controller from '@ember/controller';

import { inject as service } from '@ember/service';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

export default class FilterResultsController extends Controller {
  // --------------------------------------------------
  // Services
  // --------------------------------------------------
  @service search;

  // --------------------------------------------------
  // Tracked
  // --------------------------------------------------
  @tracked page;
  @tracked name;
  @tracked locations = [];

  // --------------------------------------------------
  // Default values for query params
  // --------------------------------------------------
  pageSize = 10;
  sort = 'id';
  direction = 'desc';

  // --------------------------------------------------
  // METHODS
  // --------------------------------------------------
  // get publishedNames() {
  //   return [true, false];
  // }

  // Filter changed
  // Return to page 1 and update tracked property
  filterChanged(attributeName, value) {
    console.log('Filter changed:', attributeName, value);
    this.page = 1;
    this[attributeName] = value;
  }

  nameChanged = (value) => this.filterChanged('name', value);
  // publishedChanged = (value) => this.filterChanged('published', value);
}
