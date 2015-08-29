class PatentPresenter < ModelPresenter

  def data
    {
      title: title,
      patent_number: patent_number,
      patent_raw: patent,
    }.merge(headers).merge(parsed_tables)
  end

  def filename
    title.present? ? (title.parameterize + ".csv") : "patent-without-title.csv"
  end
  
  def text_with_header(header)
    # find paragraph following header
    p = header.next_element
    p.text if p
  end

  def page
    page = Nokogiri::HTML(body)
    page.search('.//img|.//script').remove
    page
  end
  
  def title
    @title ||= page.css('font[size="+1"]').first.try(:text).try(:strip)
  end

  def parsed_tables
    @parsed_tables ||=
      begin
        {}.tap do |parsed_table_data|
          tables.each do |table|
            rows(table).each do |row|
              th = row.css('th')
              td = row.css('td')
              if (th.count == 1) && (td.count == 1)
                key = th.text
                val = td.text
                parsed_table_data[key] = val if key.present? && val.present?
              end
            end
          end
        end
      end
  end
  
  def headers
    @headers ||=
      begin
        {}.tap do |headers|
          page.css('center').each do |header|
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
    if (tables[2].present?)
      @patent ||= rows(tables[2]).map{|row| cells(row).map{|r| r.text.strip}}.join(" ")
    end
  end

  def patent_number
    patent.to_s =~ /Patent\s([\d,]+)\s.*/
    $1
  end

  def tables
    @tables ||= page.css('table')
  end

  def rows(table)
    table.css('tr')
  end

  def cells(row)
    row.css('td')
  end
end
