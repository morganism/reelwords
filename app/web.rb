# app.rb

require 'sinatra/base' # Require sinatra/base for modular applications
require_relative '../lib/reel_words'  # Ensure this points to your game logic Ruby file

class ReelWordsApp < Sinatra::Base
  set :port, 4568
  # Initialize the game outside of request handlers to persist its state
  @@game = ReelWords.new


  get '/' do
    @letters = @@game.letters  # Set instance variable for use in ERB template
    @scores = @@game.scores
    @word = params[:w]
    @score = params[:s]
    @total_score = @@game.total_score
    erb :index  # Render views/index.erb
  end

  post '/' do
    input = params[:letters]
    if @@game.valid_input?(input) && @@game.trie.search(input)
      @@game.update_reels(input)
      word = input
      score = @@game.calculate_score(input)
      total_score = @@game.total_score 
      "Word accepted: #{input}, Score: #{score}<br><a href='/'>Try another word</a>"

      "<script>
      setTimeout(callBack, 2000);
      function callBack() {
        location.href = '?s=#{score}&ts=#{total_score}&w=#{word}';
        }
    </script>"
    else
      "Word #{input} not found in dictionary or invalid input.<br><a href='/'>Try again</a>"
    end
  end

  # Start the server if this file is run directly
  run! if app_file == $0
end

