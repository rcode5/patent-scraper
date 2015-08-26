class ScrapedPatent < ActiveRecord::Base
  def parsed(remove_tags:)
    @parsed ||=
      begin
        doc = Nokogiri::HTML.parse(body)
        if remove_tags.present?
          remove_tags.each do |tag|
            doc.search(".//#{tag}").remove
          end
        end
      end
  end
end
