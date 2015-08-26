require 'open-uri'
class Fetcher
  def self.fetch(url, opts = {})
    open(url).read
  end
end
