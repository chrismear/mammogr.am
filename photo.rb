require 'dm-core'

class Photo
  include DataMapper::Resource
  
  property :id, Serial
  property :instagram_id, Integer
  property :image_url, String, :length => 255
  property :link_url, String, :length => 255
  property :username, String, :length => 255
  
  belongs_to :tag
end
