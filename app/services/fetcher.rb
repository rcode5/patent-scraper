require 'open-uri'
class Fetcher
  def self.fetch(url, opts = {})
    doc = Nokogiri::HTML.parse(open(url).read)
    tags_to_remove = opts[:remove_tags] || []
    tags_to_remove.each do |tag|
      doc.search(".//#{tag}").remove
    end
    doc
  end
end
