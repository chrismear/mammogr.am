require 'sinatra/base'

class Mammogram < Sinatra::Base
  get '/' do
    "Hello world!"
  end
end
