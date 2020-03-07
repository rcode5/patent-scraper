class PagesController < ApplicationController
  def root
    @patent_queries = PatentQuery.all.map { |pq| PatentQueryPresenter.new(pq) }
  end

  def query
    results_page = UsptoQueryService.query(query_params)
    url = "local:#{query_params.to_json}"
    page, links = PatentQueryService.process_query_results_page(results_page)
    terms = [
      [query_params['TERM1'].presence, query_params['FIELD1'].presence],
      [query_params['TERM2'].presence, query_params['FIELD2'].presence],
    ]
    name = terms.map { |items|
      "#{items.first} in #{items.last}" if items.all?
      "#{items.first} anywhere" if items.first
    }.compact.join ' and '
    @query = PatentQueryService.find_or_create({ name: name, url: url, links: links })
    redirect_to patent_query_path(@query)
  end

  def scrape
    opts = process_params
    url = opts[:url]
    name = opts[:name].presence || Time.zone.now.strftime('%e %B, %Y %H:%M %P %Z')
    force_update = opts[:force_update]

    (redirect_to(root_path, alert: 'You need to specify an starting query url') && return) if url.blank?

    domain = "#{url.scheme}://#{url.host}"
    puts 'domain', domain
    page, links = PatentQueryService.process_query_results_page(Fetcher.fetch(url), domain)
    @query = PatentQueryService.find_or_create({ name: name, url: url.to_s, links: links }, force_update)
    redirect_to patent_query_path(@query)
  end

  private

  def process_params
    {
      url: url_param,
      force_update: params[:force_update] == 'on',
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

  def query_params
    params.permit('TERM1', 'TERM2', 'FIELD1', 'FIELD2')
  end
end
