ENV['RACK_ENV'] ||= 'development'
require 'sinatra/base'
require_relative 'data_mapper_setup'
require 'sinatra/flash'
class Bookmark < Sinatra::Base
  register Sinatra::Flash

  enable :sessions
  set :session_secret, 'super secret'

  get '/links' do
    @links = Link.all

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

  get '/register' do
    erb :sign_up
  end

  post '/users' do
     user = User.create(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])

    if user.save
      session[:user_id] = user.id
      redirect '/links'
    else
      flash.next[:errors] = user.errors.full_messages
      redirect '/register'
    end
  end

  get '/sessions/new' do
    erb :'/sessions/new'
  end

  post '/sessions' do
  user = User.authenticate(params[:email], params[:password])
  if user
    session[:user_id] = user.id
    redirect to('/links')
  else
    flash.next[:errors] = ['The email or password is incorrect']
    redirect :'sessions/new'
  end
end


helpers do
  def current_user
    @current_user ||= User.get(session[:user_id])
  end
end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
