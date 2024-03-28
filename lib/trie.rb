#!/usr/bin/env ruby


class TrieNode
  attr_accessor :children, :is_end

  def initialize
    @children = {}
    @is_end = false
  end
end

class Trie

  def initialize
    @root = TrieNode.new
  end

  def insert(word)
    node = @root
    word.each_char do |char|
      node.children[char] ||= TrieNode.new
      node = node.children[char]
    end
    node.is_end = true
  end

  def search(word)
    node = search_node(word)
    node && node.is_end
  end

  def delete(word)
    delete_recursive(@root, word, 0)
  end

  private

  def search_node(word)
    node = @root
    word.each_char do |char|
      return nil unless node.children[char]
      node = node.children[char]
    end
    node
  end

  def delete_recursive(node, word, index)
    return if node.nil?

    if index == word.length
      node.is_end = false
      return node.children.empty?
    end

    char = word[index]
    should_delete = delete_recursive(node.children[char], word, index + 1)

    if should_delete
      node.children.delete(char)
      node.children.empty?
    else
      false
    end
  end
end

# if running as a script
if __FILE__ == $0
  @trie = Trie.new

  @trie.insert("apple")
  @trie.insert("apply")

  puts "apple is defined " if  @trie.search("apple")
  puts "apply is defined " if  @trie.search("apply")


end
