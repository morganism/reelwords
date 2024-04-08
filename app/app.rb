# app.rb

require 'sinatra'

class MyApp < Sinatra::Base
  set :views, File.expand_path('../views', __FILE__)
  get '/' do
    erb :index
  end

  get '/help' do
    "Need some help?"
  end

  get '/about' do
    "About us"
  end

  get '/login' do
    "Login page"
  end

  get '/logout' do
    "Logout page"
  end

  get '/contact' do
    "Contact us"
  end

  get '/settings' do
    "Settings page"
  end

  get '/home' do
    "Home page"
  end

  get '/admin' do
    "Admin panel"
  end

  get '/debug' do
    "Debugging page"
  end
end

# Run the app if executed directly
run MyApp.run! if __FILE__  == $0

