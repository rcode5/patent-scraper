class PagesController < ApplicationController

  def root
  end

  def scrape
    url = URI.parse(params[:url])
    domain = "#{url.scheme}://#{url.host}"
    page = Fetcher.fetch(url)
    links = page.css("a").select{|link| link['href'] =~ /nph-Parser/}
    
    @links = links.map{|l| File.join(domain, l['href']) }
  end
end
