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

class Tag
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, :length => 255
  property :last_fetched_at, Time
  
  has n, :photos
end
