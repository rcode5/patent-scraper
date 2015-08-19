require 'open-uri'
class Fetcher
  def self.fetch(url, opts = {})
    doc = Nokogiri::HTML.parse(open(url).read)
    doc.search(".//img").remove if opts[:remove_images]
    doc.search(".//script").remove if opts[:remove_scripts]
    doc
  end
end
