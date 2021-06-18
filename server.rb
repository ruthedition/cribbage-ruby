require 'sinatra'
require_relative './cribbage.rb'
require 'json'
require 'sinatra/cross_origin'


configure do
  enable :cross_origin
end

before do 
  content_type :json
  response.headers['Access-Control-Allow-Origin'] = "*"
end 

post '/besthand' do
  cards = JSON.parse(request.body.read)["cards"]
  combinations = cards.permutation(4).to_a
  PointHelper.calculate_points(combinations).to_json
end

options "*" do
  response.headers["Allow"] = "GET, PUT, POST, DELETE, OPTIONS"
  response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
  response.headers["Access-Control-Allow-Origin"] = "*"
  200
end

