require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    charset = Array('A'..'Z')
    10.times do
      @letters << charset.sample
    end
  end

  def score
    a = params[:word].chars
    @score = 0
    if a.all? { |letter| params[:word].count(letter) <= params[:letters].downcase.count(letter) }
      url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
      correct_word = open(url).read
      word = JSON.parse(correct_word)
      if word['found'] == true
        @score += params[:word].length
        @test = "Congratulations! #{params[:word].upcase} is a valid English word!"
      else
        @test = "Sorry but #{params[:word].upcase} does not seem to be a valid English word.."
      end
    else
      @test = "Sorry but #{params[:word].upcase} can't be built from #{params[:letters]}"
    end
    session[:score] += @score
  end
end
