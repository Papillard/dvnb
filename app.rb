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

get "/programme" do
  erb :programme
end

get '/tarifs' do
  erb :tarifs
end

get '/equipe' do
  erb :equipe
end

get '/contact' do
  erb :contact
end

get '/jobs' do
  erb :jobs
end

get '/legal' do
  erb :legal
end

get '/about' do
  erb :about
end


post "/" do 
  User.create(:email=>params[:email])
  if params[:email].empty?
    @warning = true
    @notice_title = "Oups !"
    @notice_desc = "Nous n'avons pas compris votre mail.."
  else
    @notice_title = "Merci, #{params[:email]}"
    @notice_desc = "Nous vous contacterons pour le prochain D&B !"
  end
  erb :landing_page
end

helpers do
  # No helpers for the moment !
end


