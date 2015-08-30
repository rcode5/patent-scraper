class PatentQueryPresenter < ModelPresenter

  def name
    super || "blank"
  end

  def patents
    @patents ||= PatentScraperService.where(url: links)
  end
end
