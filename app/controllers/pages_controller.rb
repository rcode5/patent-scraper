class PagesController < ApplicationController

  def root
  end

  def scrape
    opts = process_params
    url = opts[:url]
    force_update = opts[:force_update]

    (redirect_to(root_path, alert: 'You need to specify an starting query url') and return) unless url.present?

    domain = "#{url.scheme}://#{url.host}"
    page = Nokogiri::HTML(Fetcher.fetch(url))
    links = page.css("a").select do |link|
      begin
        uri = URI.parse link['href']
        uri.path =~ /^\/netacgi\/nph-Parser/
      rescue URI::Error
        nil
      end
    end.map{|l| File.join(domain, l['href']) }.uniq
    @query = PatentQueryService.find_or_create(url, links, force_update)
  end

  private
  def process_params
    {
      url: url_param,
      force_update: params[:force_update].present?
    }
  end

  def url_param
    url = params[:url]
    if url.present?
      begin
        URI.parse(url)
      rescue URI::Error
        nil
      end
    end
  end
    

end
