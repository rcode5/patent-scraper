class ScrapedPatent < ActiveRecord::Base
  def parsed
    @parsed ||=
      Nokogiri::HTML.parse(body)
  end
end
