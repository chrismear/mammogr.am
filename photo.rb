require 'dm-core'
require 'dm-validations'

class Photo
  include DataMapper::Resource
  
  property :id, Serial
  property :instagram_id, Integer, :required => true
  property :image_url, String, :length => 255, :required => true
  property :link_url, String, :length => 255, :required => true
  property :username, String, :length => 255, :required => true
  property :flagged_at, Time
  property :latitude, Decimal, :precision => 18, :scale => 10
  property :longitude, Decimal, :precision => 18, :scale => 10
  
  belongs_to :tag
  
  validates_uniqueness_of :instagram_id
  
  def latitude_or_random
    latitude || rand * 150.0 - 75
  end
  
  def longitude_or_random
    longitude || rand * 250.0 - 100
  end
end
