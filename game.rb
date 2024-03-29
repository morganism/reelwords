#!/usr/bin/env ruby

require 'securerandom'
require 'yaml'

require_relative 'lib/trie'

DATA_DIR = File.expand_path(File.join(File.dirname(__FILE__), 'data'))
DICTIONARY = File.expand_path(File.join(DATA_DIR, 'american-english-large.txt'))
REELS = File.expand_path(File.join(DATA_DIR, 'reels.txt'))
SCORES = File.expand_path(File.join(DATA_DIR, 'scores.txt'))

class Letters
  attr_reader :letters
  def initialize(letters = {})
    @letters = letters
  end

  def to_s
    @letters
  end
end

class Reels
  attr_reader :reels

  def initialize(*rs)
    @reels = []
    @reels << rs if rs.size > 0
  end

  def add(reel)
    puts "xxx#{reel}xxx"
    puts "xxx#{reels.nil?}xxx"
    @reels << reel
  end

  def advance_reels(reels_to_advance = (0..5))
    debug "advance reels #{reels_to_advance}"

    debug reels_to_advance
    reels_to_advance.each { |i| @reels[i].advance }
  end

  def current_letters
     @reels.map(&:current_letter) # "visible" letter of each Reel
  end
end

class Reel
  def initialize(reel_number, letters, options = {})
    @debug = true if options[:debug]
    debug "debug is on #{@debug}"
    @reel_number = reel_number
    @letters = letters
    @idx = 0
    current_letter
  end

  def current_letter
    @letters[@idx]
  end

  def randomise_idx
    @idx = SecureRandom.random_number(@letters.size)
    self
  end

  def advance
    @idx = @idx < (@letters.size - 1) ? @idx + 1 : 0
    self
  end

  def to_s
    current_letter
  end
end

oReels = Reels.new #This will hold our 6 Reel objects

def load_letters
  debug "loading letters from scores.txt"
  letter_hash = {}
  File.readlines(SCORES).each do |line|
    line.chomp!
    (letter, score) = line.split
    letter_hash[letter] = score
  end
  Letters.new(letter_hash)
end

def load_reels(letters_obj, reels_obj)
  oLetters = letters_obj
  oReels = reels_obj
  i = 0
  File.readlines(REELS).each do |line|
    line.chomp!
    letters = line.split
    selected_items = oLetters.letters.select { |k,_| letters.include? k }
    debug "#{letters} #{selected_items} letetet"
    oReels.add(Reel.new(i, letters, debug: true))
    i += 1
  end
end


def debug(*msg)
  puts msg if @debug
end


oLetters = load_letters
puts oReels.class
load_reels(oLetters, oReels)


puts "CURRENT LETTERS=[#{oReels.current_letters}]xxxxx"
oReels.advance_reels
puts "CURRENT LETTERS=[#{oReels.current_letters}]xxxxx"
oReels.advance_reels
puts "CURRENT LETTERS=[#{oReels.current_letters}]xxxxx"



