class PagesController < ApplicationController

  def root
  end

  def scrape
    (redirect_to(root_path, alert: 'You need to specify an starting query url') and return) unless url_param.present?
    url = url_param
                                                                                           
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
    
    @links = links.map{|l| File.join(domain, l['href']) }.uniq
  end

  def url_param
    url = params[:url]
    if url.present?
      URI.parse(url)
    end
  end
end
