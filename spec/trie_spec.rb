require 'trie'

RSpec.describe Trie do
  let(:trie) { Trie.new }

  describe '#insert' do
    context 'when a new word is inserted' do
      it 'stores the word in the trie' do
        trie.insert('hello')
        node = trie.instance_variable_get(:@root)

        'hello'.each_char do |char|
          expect(node.children).to have_key(char)
          node = node.children[char]
        end

        expect(node.end_of_word).to be true
      end
    end
  end

  describe '#search' do
    before do
      trie.insert('test')
    end

    context 'when the word exists' do
      it 'returns true' do
        expect(trie.search('test')).to be true
      end
    end

    context 'when the word does not exist' do
      it 'returns false' do
        expect(trie.search('hello')).to be false
      end
    end

    context 'when searching for a prefix of a stored word' do
      it 'returns false' do
        expect(trie.search('tes')).to be false
      end
    end

    context 'when the trie is empty' do
      let(:empty_trie) { Trie.new }

      it 'returns false for any search' do
        expect(empty_trie.search('anything')).to be false
      end
    end
  end
end

