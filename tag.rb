require 'dm-core'

class Tag
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, :length => 255
  property :last_fetched_at, DateTime
  
  has n, :photos
end
