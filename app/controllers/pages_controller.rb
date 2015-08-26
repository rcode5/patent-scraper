class PagesController < ApplicationController

  def root
  end

  def scrape
    url = URI.parse(params[:url])
    domain = "#{url.scheme}://#{url.host}"
    page = Nokogiri::HTML(Fetcher.fetch(url))
    links = page.css("a").select do |link|
      begin
        uri = URI.parse link['href']
        uri.path =~ /^\/netacgi\/nph-Parser/
      rescue URI::Error
        nil
      end
    end
    
    @links = links.map{|l| File.join(domain, l['href']) }
  end

end
