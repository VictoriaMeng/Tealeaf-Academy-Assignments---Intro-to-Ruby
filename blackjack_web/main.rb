require 'rubygems'
require 'sinatra'
require "sinatra/reloader" if development?

use Rack::Session::Cookie, :key => 'rack.session',
                           :path => '/',
                           :secret => 'random_string' 

helpers do 
	def hand_total(hand)
		total = 0
		hand.each do |card| 
			total += card[0][1]
		end
		hand.select{|card| card[0][1] == 11}.count.times do
			break if total <= 21
			total -= 10
		end
		total
	end

	def get_image(card)
		"<img src='/images/cards/#{card[1].downcase}_#{card[0][0].downcase}.jpg'>"
	end
end

get '/' do
	if session[:player_name].empty?
		redirect "/name_form"
	else
		redirect "/game"
	end
end

get "/name_form" do
	erb :name_form
end

post "/post_name" do
	session[:player_name] = params[:player_name]
	redirect "/game"
end

get "/game" do
	suits = ["Clubs", "Diamonds", "Hearts", "Spades"]
	cards = [["Ace", 11], ["2", 2], ["3", 3], ["4", 4], ["5", 5], ["6", 6], ["7", 7], ["8", 8], ["9", 9], ["10", 10], ["Jack", 10], ["Queen", 10], ["King", 10]]
	
	
	session[:deck] = cards.product(suits).shuffle!
	session[:game_state] = "player_turn"

	session[:player_hand] = []
	session[:dealer_hand] = []

	2.times do
		session[:player_hand] << session[:deck].pop
		session[:dealer_hand] << session[:deck].pop
	end

	hand_total(session[:player_hand])
	hand_total(session[:dealer_hand])

	session[:game_state] = "player_blackjack" if hand_total(session[:player_hand]) == 21
	session[:game_state] = "dealer_blackjack" if hand_total(session[:dealer_hand]) == 21

	erb :game
end

get "/hit_or_stay" do
	if params[:hit_or_stay] == "Hit"
		session[:player_hand] << session[:deck].pop
		hand_total(session[:player_hand])
		session[:game_state] = "player_bust" if hand_total(session[:player_hand]) > 21
	elsif params[:hit_or_stay] == "Stay"
		session[:game_state] = "dealer_turn" if hand_total(session[:dealer_hand]) < 17
		if (hand_total(session[:dealer_hand]) >= 17) && (hand_total(session[:dealer_hand]) < hand_total(session[:player_hand]))
			session[:game_state] = "player_win" 
		elsif (hand_total(session[:dealer_hand]) >= 17) && (hand_total(session[:dealer_hand]) >= hand_total(session[:player_hand]))
			session[:game_state] = "dealer_win"
		end
	end
	erb :game
end

get "/play_again" do
	redirect "/game" if params[:play_again] == "Play Again!"
end

get "/dealer_card" do
	session[:dealer_hand] << session[:deck].pop
	hand_total(session[:dealer_hand])
	session[:game_state] = "dealer_bust" if hand_total(session[:dealer_hand]) > 21
	if hand_total(session[:dealer_hand]) <= 21
		if (hand_total(session[:dealer_hand]) >= 17) && (hand_total(session[:dealer_hand]) < hand_total(session[:player_hand]))
			session[:game_state] = "player_win" 
		elsif (hand_total(session[:dealer_hand]) >= 17) && (hand_total(session[:dealer_hand]) >= hand_total(session[:player_hand]))
			session[:game_state] = "dealer_win"
		end
	end
	erb :game
end
		