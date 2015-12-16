ENV['RACK_ENV'] ||= 'development'
require 'sinatra/base'
require './lib/link.rb'

class Bookmark < Sinatra::Base
  get '/' do
    erb(:index)
  end

  get '/links' do
    @links = Link.all
    erb(:links)
  end

  get '/add' do
    erb(:add)
  end

  post '/add' do
    Link.create(url: params[:url], title: params[:title])
    redirect '/links'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
