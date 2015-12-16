ENV['RACK_ENV'] ||= 'development'
require 'sinatra/base'
require_relative 'data_mapper_setup'
#require './app/model/tag.rb'
class Bookmark < Sinatra::Base
  # get '/' do
  #   erb(:index)
  # end
  get '/links' do
    @links = Link.all
    # @tags = Tag.all
    erb :'links/index'
  end

  get '/links/add' do
    erb :'links/add'
  end

  post '/links' do
    link = Link.create(url: params[:url], title: params[:title])
    tag = Tag.create(tags: params[:tags])
    link.tags << tag
    link.save
    redirect '/links'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
