require 'rubygems'
require "sinatra"
require "sinatra/activerecord"

#set :database, "postgres:///dnb.db"

class User < ActiveRecord::Base
end

get "/" do
  @users = User.order("created_at DESC")
  erb :landing_page
end


helpers do
  # No helpers for the moment !
end