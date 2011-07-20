class Activity < ActiveRecord::Base
  has_many :logs
  
  cattr_reader :per_page
  @@per_page = 10
end
