require 'open-uri'
class Fetcher
  def self.fetch(url)
    Nokogiri::HTML.parse(open(url).read)
  end
end
