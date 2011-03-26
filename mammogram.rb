require 'sinatra/base'
require 'haml'

require 'load_app_settings'
require 'models'

set :haml, :format => :html5

class Mammogram < Sinatra::Base
  get '/' do
    @photos = Photo.all
    haml :photos
  end
end
