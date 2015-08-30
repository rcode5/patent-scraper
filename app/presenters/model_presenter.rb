class ModelPresenter < SimpleDelegator
  attr_reader :model
  def initialize(model)
    super
    @model = model
  end
end
