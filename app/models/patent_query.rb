class PatentQuery < ActiveRecord::Base
  validates :url, uniqueness: true
  serialize :links, Array
end
