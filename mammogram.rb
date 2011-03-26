require 'sinatra/base'
require 'yaml'
require 'instagram'
require 'haml'

set :haml, :format => :html5

APP_SETTINGS = YAML.load(File.open('local_settings.yml'))

Instagram.configure do |config|
  config.client_id = APP_SETTINGS[:instagram][:client_id]
end

class Mammogram < Sinatra::Base
  get '/' do
    "Hello world!"
  end
  
  get '/photos' do
    client = Instagram.client
    @media = client.tag_recent_media('snow')
    haml :photos
  end
end
