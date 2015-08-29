class PatentQueryService

  def self.find_or_create(url, links, force_update = false)
    url = url.to_s
    query = PatentQuery.find_by(url: url)
    if !query
      query = PatentQuery.create(url: url, links: links)
    elsif force_update
      query.update_attributes!(links: links)
    end
    PatentQueryPresenter.new(query)
  end
  
end
