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
  
  
  property :email, String, :required => true, :unique => true,
     :format   => :email_address,
     :messages => {
       :presence  => "Nous avons besoin d'une adresse email!",
       :is_unique => "Nous avons déjà noté cette adresse email!",
       :format    => "Cela ne ressemble pas à une adresse email :("
     }
  
end

DataMapper.finalize
DataMapper.auto_upgrade!

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
  @user = User.new(:email=>params[:email])
  if(@user.save)
    @message = "Merci! Nous vous contacterons très prochainement!"
  else
    @user.errors.each do |e|
        puts e
      end
  end
  erb :landing_page
end

helpers do
  # No helpers for the moment !
end


