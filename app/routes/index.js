import Ember from 'ember';

export default Ember.Route.extend({
    activate: function() {
        var config = Ember.$.getJSON('assets/config');
        console.log(config);
    }
});
