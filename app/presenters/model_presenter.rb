class ModelPresenter < SimpleDelegator

  delegate :url_helpers, to: 'Rails.application.routes' 
  
  attr_reader :model
  def initialize(model)
    super
    @model = model
  end
end
