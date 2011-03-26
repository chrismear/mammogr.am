#!/usr/bin/env ruby

require 'bundler'

require 'load_app_settings'
require 'models'

TAG_NAMES = ['snow', 'ice']

# Ensure tags in DB match tags in canonical list
TAG_NAMES.each do |tag_name|
  unless Tag.all(:name => tag_name).count > 0
    tag = Tag.create(:name => tag_name)
  end
end
Tag.all.each do |tag|
  unless TAG_NAMES.include?(tag.name)
    tag.photos.destroy
    tag.destroy
  end
end

puts "Fetching new media"

require 'instagram'

Instagram.configure do |config|
  config.client_id = APP_SETTINGS[:instagram][:client_id]
end

client = Instagram.client
puts "client: #{client.inspect}"


# Fetch new media
Tag.all.each do |tag|
  if tag.last_fetched_at.nil? || ((Time.now.utc - tag.last_fetched_at.to_time) > 3600)
    tag.photos.destroy
    
    puts "Fetching new media for tag #{tag.name}"
    
    media = client.tag_recent_media(tag.name, :count => 50)
    media.each do |medium|
      photo = Photo.create(
        :instagram_id => medium.id,
        :image_url => medium.images.thumbnail.url,
        :link_url => medium.link,
        :username => medium.user.username,
        :tag => tag
      )
    end
    
    tag.last_fetched_at = Time.now.utc
    tag.save
  end
end
