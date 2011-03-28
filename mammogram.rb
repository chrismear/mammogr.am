require 'sinatra/base'
require 'haml'

require 'init'

class Mammogram < Sinatra::Base
  set :haml, :format => :html5
  set :root, File.dirname(__FILE__)
  # set :static, true
  
  get '/' do
    # FIXME Make random not hilarious bad here.
    @photos = Photo.all.to_a.sort_by{rand}[0..24]
    haml :photos
  end
  
  get '/photos/random' do
    @photo = Photo.first(:offset => rand(Photo.count))
    haml :photo
  end
  
  post '/photos/:id/flag' do
    @photo = Photo.get(params[:id])
    @photo.flagged_at = Time.now.utc
    @photo.save
    "OK"
  end
  
  get "/#{APP_SETTINGS[:admin_secret]}" do
    @flagged_photos = Photo.all(:flagged_at.not => nil)
    @admin_secret = APP_SETTINGS[:admin_secret]
    haml :admin
  end
  
  post "/#{APP_SETTINGS[:admin_secret]}/photos/:id/destroy" do
    @photo = Photo.get(params[:id])
    Deletion.create(:instagram_id => @photo.instagram_id)
    @photo.destroy
    redirect ("/#{APP_SETTINGS[:admin_secret]}")
  end
  
  post "/#{APP_SETTINGS[:admin_secret]}/photos/:id/reset" do
    @photo = Photo.get(params[:id])
    @photo.flagged_at = nil
    @photo.save
    redirect ("/#{APP_SETTINGS[:admin_secret]}")
  end
end
