bird_sighting.views.bird_sighting = Backbone.View.extend({
  className: "bird_sighting",

  events:{
    'click .actions .delete': 'delete'
  },

  render: function() {

    $(this.el).html(bird_sighting.templates['bird_sighting'](this.model.toJSON()))

    return this

  },

  delete: function(){
    this.model.destroy()
  }

});