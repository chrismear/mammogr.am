require 'yaml'

if File.exist?('local_settings.yml')
  APP_SETTINGS = YAML.load(File.open('local_settings.yml'))
else
  APP_SETTINGS = {
    :instagram => {
      :client_id => ENV['MAMMOGRAM_INSTAGRAM_CLIENT_ID']
    },
    :database_url => ENV['DATABASE_URL']
  }
end
