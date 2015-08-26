class ModelPresenter < SimpleDelegator
  def initialize(model)
    super
    @model = model
  end
end
