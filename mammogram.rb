require 'sinatra/base'
require 'haml'

require 'init'

class Mammogram < Sinatra::Base
  set :haml, :format => :html5
  set :root, File.dirname(__FILE__)
  # set :static, true
  
  get '/' do
    # FIXME Make random not hilarious bad here.
    @photos = Photo.all.to_a.sort_by{rand}[0..15]
    haml :photos
  end
end
