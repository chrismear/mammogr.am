require 'sinatra/base'
require 'haml'

require 'init'

set :haml, :format => :html5

class Mammogram < Sinatra::Base
  get '/' do
    # FIXME Make random not hilarious bad here.
    @photos = Photo.all.to_a.sort_by{rand}[0..15]
    haml :photos
  end
end
