require 'dm-core'

class Deletion
  include DataMapper::Resource
  
  property :id, Serial
  property :instagram_id, Integer, :required => true
end
