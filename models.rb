require 'dm-core'

DataMapper.setup(:default, APP_SETTINGS[:database_url])

require 'photo'
require 'tag'
require 'deletion'

DataMapper.finalize

require 'dm-migrations'

DataMapper.auto_upgrade!
