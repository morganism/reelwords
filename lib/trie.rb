class TrieNode
  attr_accessor :children, :end_of_word

  def initialize
    @children = {}
    @end_of_word = false
  end
end

class Trie
  def initialize
    @root = TrieNode.new
  end

  def insert(word)
    node = @root
    word.each_char do |char|
      node.children[char] = TrieNode.new unless node.children[char]
      node = node.children[char]
    end
    node.end_of_word = true
    # Append a TrieNode with the character '=' to signify the end of a word as 
    # in Scopely Challenge doc 
    #
    # the following node is not necessary
    node.children['='] = TrieNode.new unless node.children['=']
  end

  def search(word)
    node = @root
    word.each_char do |char|
      return false unless node.children[char]
      node = node.children[char]
    end
    # Ensure the '=' node exists to confirm it's the end of a word
    node.end_of_word && node.children.include?('=')
  end
end

