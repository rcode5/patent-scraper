class PatentQueryService

  def self.process_query_results_page(page, domain = nil)
    domain ||= 'http://patft.uspto.gov/'
    page = Nokogiri::HTML(page)
    links = page.css("a").select do |link|
      begin
        uri = URI.parse link['href']
        uri.path =~ /^\/netacgi\/nph-Parser/
      rescue URI::Error
        nil
      end
    end.map{|l| File.join(domain, l['href']) }.uniq
    [page, links]
  end
  
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
