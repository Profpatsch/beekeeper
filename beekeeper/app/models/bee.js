import DS from 'ember-data';

export default DS.Model.extend({
    name: DS.attr(),
    'class': DS.attr(),
    description: DS.attr()
});
