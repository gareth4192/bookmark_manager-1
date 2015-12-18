require 'data_mapper'
require 'dm-postgres-adapter'
require './app/model/link.rb'
require './app/model/tag.rb'
require './app/model/users.rb'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/bookmark_manager_#{ENV['RACK_ENV']}")
DataMapper.finalize
