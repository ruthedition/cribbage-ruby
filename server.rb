require 'sinatra'
require './cribbage'

post '/best_hand' do
  combinations = params[:cards].permutation(4).to_a
  PointHelper.calculate_points(combinations)
end

