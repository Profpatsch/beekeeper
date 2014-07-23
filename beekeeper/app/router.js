import Ember from 'ember';

var Router = Ember.Router.extend({
  location: BeekeeperENV.locationType
});

Router.map(function() {
    this.route('bees');
    this.route('chains');
});

export default Router;
