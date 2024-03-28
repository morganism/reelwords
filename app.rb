$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'sinatra'
require_relative 'database'
require 'trie'

DATA_DIR = File.join(File.dirname(__FILE__), 'data/game')

# Method to load reels data from file
def load_reels_data(f)
  reels_data = File.readlines(File.join(DATA_DIR, f)).map(&:chomp)
  reels_data.map { |line| line.split(',') }
end

# Method to load scores data from file
def load_scores_data(f)
  scores_data = {}
  File.foreach(File.join(DATA_DIR, f)) do |line|
    letter, score = line.chomp.split(',')
    scores_data[letter] = score.to_i
  end
  scores_data
end

def build_trie(f)
  @trie = Trie.new
    
  @trie.insert("apple")
  @trie.insert("Appl")
  @trie.insert("Appler")
  @trie.insert("applenty")
    
  puts "apple is defined " if  @trie.search("apple")
end

# Load reels and scores data when the server starts up
configure do
  set :reels, load_reels_data('reels.txt')
  set :scores, load_scores_data('scores.txt')
  set :trie, build_trie('american-english-large.txt')
end



# Define routes
get '/' do
  'Welcome to the ReelWords Game Server!'
end


# Route to search for a word in the trie
get '/search/:word' do
  word = params['word']
  if settings.trie.search(word)
    "The word '#{word}' exists in the dictionary."
  else
    "The word '#{word}' does not exist in the dictionary."
  end
end

# Route to handle invalid routes
not_found do
  "Route not found. Please check your URL."
end

# Run the app using Sinatra's built-in server if executed directly
if __FILE__ == $0
  set :port, 2626
  #run Sinatra::Application
  Sinatra::Application.run
end

