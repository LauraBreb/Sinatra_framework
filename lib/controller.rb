require 'bundler'
Bundler.require

$:.unshift File.expand_path("./../lib", __FILE__)
require 'gossip'

class ApplicationController < Sinatra::Base

  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new("#{params['author']}","#{params['content']}").save
    redirect'/'
  end

  get '/gossips/:id' do
      erb :show, locals: {gossip: Gossip.find("#{params['id']}"), id: "#{params['id']}"}
  end

end