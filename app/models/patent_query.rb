class PatentQuery < ApplicationRecord
  validates :url, uniqueness: true
  serialize :links, Array
end
