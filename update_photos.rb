#!/usr/bin/env ruby

require 'bundler'

require 'init'

TAG_NAMES = %w{
  bewbs
  bewbz
  boob
  boobies
  boobz
  bra
  breast
  breasts
  busty
  cleavage
  corset
  titties
}

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

require 'instagram'

Instagram.configure do |config|
  config.client_id = APP_SETTINGS[:instagram][:client_id]
end

client = Instagram.client


# Fetch new media
Tag.all.each do |tag|
  begin
    if tag.last_fetched_at.nil? || ((Time.now.utc - tag.last_fetched_at) > 3600)
      tag.photos.destroy
    
      puts "Fetching new media for tag #{tag.name}"
    
      media = client.tag_recent_media(tag.name, :count => 50)
      media.each do |medium|
        unless Deletion.first(:instagram_id => medium.id)
          photo = Photo.new(
            :instagram_id => medium.id,
            :image_url => medium.images.thumbnail.url,
            :link_url => medium.link,
            :username => medium.user.username,
            :tag => tag
          )
          if medium.location
            photo.latitude = medium.location.latitude
            photo.longitude = medium.location.longitude
          end
          photo.save
        end
      end
    
      tag.last_fetched_at = Time.now.utc
      tag.save!
    end
  rescue
  end
end
