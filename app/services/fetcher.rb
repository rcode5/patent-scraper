require 'open-uri'
class Fetcher
  def self.fetch(url, opts = nil)
    opts ||= {}
    doc = Nokogiri::HTML.parse(open(url).read)
    doc.search('.//img').remove if opts[:remove_images]
    doc
  end
end
