#!/usr/bin/env ruby
# encoding: utf-8

require 'rubygems'
require "sinatra"
require 'data_mapper'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://postgres:postgres@localhost:5432/dnb")

class User
  include DataMapper::Resource
  property :id, Serial 
  property :email,  String 
  validates_presence_of :email, :message => "Il nous faut une adresse email!"
  validates_uniqueness_of :email, :message => "Nous avons déjà noté votre adresse email!"
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
  puts params
  @user = User.new(:email=>params[:email])
  if(@user.save)
    puts "user saved"
  else
    @user.errors.each do |e|
        puts e
      end
  end
end

helpers do
  # No helpers for the moment !
end


