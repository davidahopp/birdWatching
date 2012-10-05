bird_sighting.views.create_sighting = Backbone.View.extend({
  className: "create_sighting",

  events:{
    'click .actions .create': 'create'
  },

  render: function() {

    $(this.el).html(bird_sighting.templates['create_sighting']())

    return this

  },

  create: function(){
    var sighting = new bird_sighting.models.bird_sighting({
      name: this.$el.find('.name input').val(),
      location: this.$el.find('.location input').val(),
      latitude: this.$el.find('.latitude input').val(),
      longitude: this.$el.find('.longitude input').val(),
      sightingDate: this.$el.find('.sighting_date input').val()
    })
    sighting.save();
  }

});