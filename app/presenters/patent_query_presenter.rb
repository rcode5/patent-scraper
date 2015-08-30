class PatentQueryPresenter < ModelPresenter

  def name
    super || "blank"
  end

  def filename
    "patents-#{name.parameterize}.csv"
  end

  def patents
    @patents ||= PatentScraperService.where(url: links)
  end
end
