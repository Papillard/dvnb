require 'rubygems'
require "sinatra"
require 'data_mapper'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://postgres:postgres@localhost:5432/dnb")

class User
  include DataMapper::Resource
  property :id, Serial 
  property :email,  String 
  validates_presence_of :email
end

DataMapper.finalize
DataMapper.auto_migrate!

get "/" do
  erb :landing_page
end

get "/program" do
  erb :program
end

post "/" do 
  User.create(:email=>params[:email])
  if params[:email].empty?
    @warning = "Il nous manque ton mail !"
  else
    @notice_title = "Merci, #{params[:email]}"
    @notice_desc = "Nous te contacterons pour le prochain D&B !"
  end
  erb :landing_page
end

helpers do
  # No helpers for the moment !
end


