import Ember from 'ember';

var Router = Ember.Router.extend({
  location: BeekeeperENV.locationType
});

//class Router extends Ember.Router
//  location: BeekeeberENV.locationType

Router.map(function() {
    this.route('bees');
    this.route('chains');
});

//Router.map ->
//  @route 'bees'
//  @route 'chains'

export default Router;
