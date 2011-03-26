require 'dm-core'
require 'dm-validations'

class Photo
  include DataMapper::Resource
  
  property :id, Serial
  property :instagram_id, Integer, :required => true
  property :image_url, String, :length => 255, :required => true
  property :link_url, String, :length => 255, :required => true
  property :username, String, :length => 255, :required => true
  
  belongs_to :tag
  
  validates_uniqueness_of :instagram_id
end
