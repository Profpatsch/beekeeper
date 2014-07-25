import Ember from 'ember';

export default Ember.Route.extend({
    model: function() {
        this.store.push('bee', {
            id: 1,
            name: "Testbee",
            'class': "Bienenklasse",
            description: "This is a Bee test. Bzzz."
        });

        this.store.push('bee', {
            id: 2,
            name: "Testbee2",
            'class': "Bienenklasse",
            description: "This is a Bee test. Bzzz."
        });
        return this.store.filter('bee');
    }
});
