# Copyright 2011 Chris Mear.
# 
# This file is part of mammogr.am.
# 
# mammogr.am is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# mammogr.am is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Aggero General Public License for more details.
# 
# You should have received a copy of the GNU Affero General Public License
# along with mammogr.am.  If not, see <http://www.gnu.org/licenses/>.

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
