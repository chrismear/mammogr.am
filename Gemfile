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

source :rubygems

gem 'sinatra', '~>1.1.3'
gem 'instagram', '~>0.6.1'
gem 'haml', '~>3.0.25'
gem 'datamapper', '~>1.1.0'

group :development do
  gem 'thin', '~>1.2.10'
  gem 'dm-mysql-adapter', '~>1.1.0'
end

group :prodction do
  gem 'dm-postgres-adapter', '~>1.1.0'
end
