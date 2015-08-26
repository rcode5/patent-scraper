class PatentScraperService

  attr_reader :page
  def initialize(patent_url)
    raw_page ||= fetch_via_url(patent_url)
    @page = PatentPresenter.new(raw_page)
  end

  def fetch_via_url(url)
    patent = ScrapedPatent.find_by(url: url)
    unless patent
      page_data = Fetcher.fetch(url)
      patent = ScrapedPatent.create_with(body: page_data).find_or_create_by(url: url)
    end
    patent
  end
  
  def data
    {
      title: title,
      patent: patent
    }.merge(headers)
  end

  def text_with_header(header)
    # find paragraph following header
    p = header.next_element
    p.text if p
  end

  def title
    @title ||= @page.css('font[size="+1"]').first.try(:text).try(:strip)
  end

  def headers
    @headers ||=
      begin
        {}.tap do |headers|
          @page.css('center').each do |header|
            key = header.text.strip
            if key.present?
              value = text_with_header(header)
              headers[key] = value if value.present?
            end
          end
        end
      end
  end
  
  def patent
    @patent ||= rows(tables[2]).map{|row| cells(row).map{|r| r.text.strip}}
  end

  def tables
    @tables = @page.css('table')
  end

  def rows(table)
    table.css('tr')
  end

  def cells(row)
    row.css('td')
  end

end
