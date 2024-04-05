#!/usr/bin/env ruby

require_relative 'trie.rb'

DATA_DIR = File.expand_path('../data', __dir__)

class ReelWords
  attr_accessor :trie, :reels, :scores

  def initialize
    @trie = Trie.new
    @total_score = 0
    @rounds = 0
    load_words
    load_scores
    load_reels
    randomise_reels
  end

  def load_words
    File.readlines("#{DATA_DIR}/american-english-large.txt").each do |word|
      @trie.insert(word.strip.downcase)
    end
  end

  def load_scores
    @scores = {}
    File.readlines("#{DATA_DIR}/scores.txt").each do |line|
      letter, score = line.strip.split(' ')
      @scores[letter] = score.to_i
    end
  end

  def load_reels
    @reels ||= File.readlines("#{DATA_DIR}/reels.txt").map do |line|
      line.strip.split(' ')
    end
  end

  def randomise_reels
    @reels ||= load_reels # avoid ordered method calls
    @reels.each { |reel| reel.rotate!(rand(reel.size)) }
  end

  def self.play #convenience
    ReelWords.new.play
  end

  def play
    intro
    loop do
      @rounds += 1
      display_letters
      input = gets.strip.downcase

      if input.length == 1
        if input == '!'    # exit game
          break
        elsif input == '?' # sometimes you cannot form a word
          randomise_reels
          next
        end
      end
      
      if valid_input?(input) && @trie.search(input)
        update_reels(input)
        puts "Points: #{calculate_score(input)}"
        puts "Total: #{@total_score}"
      else
        puts "Word #{input} not found in dictionary."
      end
    end
    outro
  end

  private

  def intro
    puts "How about a nice game of ReelWords ?"
    puts "Use the letters displayed to form a word and earn points."
    puts "Your word choice will be validated against a dictionary.\n\n"
    puts "Type '!' to exit the game, '?' to randomise the reels (if no words can be formed).\n\n"
  end

  def outro
    puts "Bye! Thank you for playing ReelWords. You accumulated #{@total_score} points in #{@rounds} rounds played."
  end

  def display_letters
    puts @reels.map { |reel| reel.first }.join(' ')
  end

  def valid_input?(input)
    temp_reels = @reels.map(&:dup)
    input.each_char.all? do |char|
      reel = temp_reels.find { |r| r.first == char }
      reel ? reel.rotate! : false
    end
  end

  def update_reels(input)
    input.each_char do |char|
      reel = @reels.find { |r| r.first == char }
      reel.rotate! until reel.first == char
      reel.rotate!
    end
  end

  def calculate_score(word)
    word.chars.sum { |char| @scores[char] }.tap { |o| @total_score += o }
  end
end

__FILE__ == $0 && ReelWords.play #no gameplay if i'm required
