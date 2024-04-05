require 'spec_helper'
require_relative '../lib/reel_words'

RSpec.describe ReelWords do
  subject(:game) { described_class.new }

  describe '#initialize' do
    it 'initializes with a trie, total score, and rounds' do
      expect(game.trie).to be_a(Trie)
      expect(game.instance_variable_get(:@total_score)).to eq(0)
      expect(game.instance_variable_get(:@rounds)).to eq(0)
    end

    it 'loads words, scores, and reels' do
      expect(game.scores).not_to be_empty
      expect(game.reels).not_to be_empty
    end
  end

  describe '#load_scores' do
    it 'loads scores into a hash' do
      game.send(:load_scores)
      expect(game.scores).to be_a(Hash)
      expect(game.scores.keys).to include('a', 'b', 'c') 
    end
  end

  describe '#load_reels' do
    it 'loads reels from a file' do
      game.send(:load_reels)
      expect(game.reels).to be_a(Array)
      expect(game.reels.first).to be_a(Array)
    end
  end

#  describe '#randomise_reels' do
#    it 'randomizes the order of letters in each reel' do
#      original_order = game.reels.dup
#      game.send(:randomise_reels)
#      expect(game.reels).not_to eq(original_order)
#    end
#  end

  # FINALLY! annoying test:  1) ReelWords#randomise_reels randomizes the order of letters in each reel
  #                Failure/Error: expect(game.reels).not_to eq(original_order)
  # inner Array is a reference retained so shallow copy .. serialize 
  describe '#randomise_reels' do
    it 'randomizes the order of letters in each reel' do
      original_order = Marshal.load(Marshal.dump(game.reels))
      game.send(:randomise_reels)
      expect(game.reels).not_to eq(original_order)
    end
  end


  describe '#calculate_score' do
    it 'calculates score based on the input word' do
      word = 'test' # Assume 'test' is a valid word with known scores for 't', 'e', and 's'
      expect(game.send(:calculate_score, word)).to be > 0
      # The expectation value could be based on real values in scores.txt
    end
  end
end

