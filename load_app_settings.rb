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

require 'yaml'

if File.exist?('local_settings.yml')
  APP_SETTINGS = YAML.load(File.open('local_settings.yml'))
else
  APP_SETTINGS = {
    :instagram => {
      :client_id => ENV['MAMMOGRAM_INSTAGRAM_CLIENT_ID']
    },
    :database_url => ENV['DATABASE_URL'],
    :admin_secret => ENV['MAMMOGRAM_ADMIN_SECRET']
  }
end
