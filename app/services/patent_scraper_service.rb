class PatentScraperService

  def self.find_or_create(url)
    patent = ScrapedPatent.find_by(url: url)
    unless patent
      page_data = Fetcher.fetch(url)
      patent = ScrapedPatent.create_with(body: page_data).find_or_create_by(url: url)
    end
    PatentPresenter.new(patent)
  end

  def self.find(url)
    patent = ScrapedPatent.find_by(url: url)
    PatentPresenter.new(patent)
  end

  def self.where(opts)
    ScrapedPatent.where(opts).map{|patent| PatentPresenter.new(patent)}
  end

end
