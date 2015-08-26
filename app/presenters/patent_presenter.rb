class PatentPresenter < ModelPresenter

  def data
    {
      title: title,
      patent: patent
    }.merge(headers).merge(parsed_tables)
  end

  def text_with_header(header)
    # find paragraph following header
    p = header.next_element
    p.text if p
  end

  def page
    Nokogiri::HTML(body).search('.//img').remove
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
    @patent ||= rows(tables[2]).map{|row| cells(row).map{|r| r.text.strip}}
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
