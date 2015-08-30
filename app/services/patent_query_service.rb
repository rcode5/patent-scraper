class PatentQueryService

  def self.find_or_create(params, force_update = false)
    params.symbolize_keys!
    query = PatentQuery.find_by(params.slice :url)
    if !query
      query = PatentQuery.create(params)
    elsif force_update
      query.update_attributes!(params.slice(:name, :links))
    end
    PatentQueryPresenter.new(query)
  end
  
end
