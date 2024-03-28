#!/usr/bin/env ruby

require_relative 'lib/trie'

DATA_DIR = File.join(File.dirname(__FILE__), 'data')
DICTIONARY = File.join(DATA_DIR, 'american-english-large.txt')
REELS = File.join(DATA_DIR, 'reels.txt')
SCORES = File.join(DATA_DIR, 'scores.txt')

class Tile
  def initialize(letter, value)
    @letter = letter
    @value = value
  end
end

def readfile(filepath)
  File.readlines(filepath).each do |line|
    puts line
  end
end
def load_scores

end
