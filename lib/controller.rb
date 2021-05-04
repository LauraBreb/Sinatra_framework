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
    erb :show, locals: {gossip: Gossip.find(params['id'].to_i), id:params['id']}
  end

  get '/gossips/:id/edit/' do
    erb :edit, locals: {id: "#{params['id']}"}
  end

  post '/gossips/:id/edit/' do
    Gossip.update("#{params['new_author']}","#{params['new_content']}", "#{params['updated_id']}")
    redirect'/'
  end

end