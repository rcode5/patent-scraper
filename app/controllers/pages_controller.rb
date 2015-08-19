class PagesController < ApplicationController

  def root
  end

  def scrape
    url = URI.parse(params[:url])
    domain = "#{url.scheme}://#{url.host}"
    page = Fetcher.fetch(url, remove_images: true)
    links = page.css("a").select do |link|
      begin
        uri = URI.parse(link['href'])
        uri.path =~ /^\/netacgi\/nph-Parser/
      rescue URI::Error
        false
      end
    end
    @links = links.map{|l| File.join(domain, l['href']) }
  end

  def subscrape
    url = URI.parse(params[:url])
    page = Fetcher.fetch(url, remove_images: true)

    @table_data = get_table_data(page).compact
    @page = page
  end

  def get_table_data(page)
    results = page.css('table tr').map do |table|
      entries = table.css('td').map{|f| f.text.strip} 
      if entries.any?{|e| e.present?}
        column = entries[0]
        values = entries[1..-1].join(" ")
        [column, values]
      end
    end.compact
  end
    
end
