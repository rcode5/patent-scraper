class PatentScraperService
  attr_reader :page
  def initialize(patent_url)
    @page = Fetcher.fetch(patent_url, remove_images: true, remove_scripts: true)
  end

  def data
  end

end
