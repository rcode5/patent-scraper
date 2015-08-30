class PagesController < ApplicationController

  def root
    @patent_queries = PatentQuery.all.map{|pq| PatentQueryPresenter.new(pq)}
  end

  def query
    render json: params.to_json
  end
  
  def scrape
    opts = process_params
    url = opts[:url]
    name = opts[:name].presence || Time.zone.now.strftime("%e %B, %Y %H:%M %P %Z")
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
    @query = PatentQueryService.find_or_create({name: name, url: url.to_s, links: links}, force_update)
    redirect_to patent_query_path(@query)
  end

  private
  def process_params
    {
      url: url_param,
      force_update: params[:force_update] == 'on'
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
