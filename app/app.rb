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

  get '/tags/:name' do
    tag = Tag.first(tags: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end


  post '/links' do
    link = Link.create(url: params[:url], title: params[:title])
    params[:tags].split(', ').each do |tag|
    tag = Tag.create(tags: tag)
    link.tags << tag
  end
    link.save
    redirect '/links'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
