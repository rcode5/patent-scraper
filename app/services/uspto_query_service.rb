class UsptoQueryService

  include HTTParty

  base_uri 'http://patft.uspto.gov/netacgi'


  BASE_QUERY = {
    "d" => 'PTXT',
    "Sect1" => 'PTO2',
    "Sect2" => "HITOFF",
    "p" => 1,
    "u" => "/netahtml/PTO/search-bool.html",
    "r" => 0,
    "f" => 'S',
    "l" => 50,
    "co1" => "AND"
  }
  #http://patft.uspto.gov/netacgi/nph-Parser?
  # Sect1=PTO2
  # &Sect2=HITOFF
  # &p=1
  # &u=%2Fnetahtml%2FPTO%2Fsearch-bool.html
  # &r=0
  # &f=S
  # &l=5
  # 0&TERM1=symyx
  # &FIELD1=ASNM
  # &co1=AND
  # &TERM2=&FIELD2=
  #   &
  #       d=PTXT  
  def self.query(query)
    params = BASE_QUERY.merge(query.stringify_keys)
    page = get '/nph-Parser', query: params
  end

end
