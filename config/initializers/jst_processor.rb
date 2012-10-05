class MyJstProcessor < Sprockets::JstProcessor
  def prepare
    @namespace = 'this.bird_sighting.templates'
  end
end
BirdWatching::Application.assets.register_engine('.jst', MyJstProcessor)