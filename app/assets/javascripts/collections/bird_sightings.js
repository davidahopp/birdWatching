bird_sighting.collections.bird_sightings = Backbone.Collection.extend({
  model: bird_sighting.models.bird_sighting,
  url: '/bird_sightings'
});