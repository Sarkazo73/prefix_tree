# frozen_string_literal: true

require_relative '../lib/tree'
require 'faker'

RSpec.describe Tree do
  describe 'tree' do
    let(:tree) { described_class.new }

    context 'when we add one word in tree' do
      let(:string) { "test" }
      before do
        tree.add_string(string: string)
      end

      it 'method list output word' do
        expect(tree.list).to contain_exactly(string)
      end

      it 'method includes? check have thee this word' do
        expect(tree.includes?(word: string)).to eq(true)
      end
    end

    context 'when we add two cognate words in tree' do
      let(:first_word) { "test" }
      let(:second_word) { "tests" }

      before do
        tree.add_string(string: first_word)
        tree.add_string(string: second_word)
      end

      it 'method list output words' do
        expect(tree.list).to contain_exactly(first_word, second_word)
      end

      it 'method includes? check have thee this words' do
        expect(tree.includes?(word: first_word)).to eq(true)
        expect(tree.includes?(word: second_word)).to eq(true)
      end
    end

    context 'when we don`t add nothing' do
      let(:nothing) { "" }

      before do
        tree.add_string(string: nothing)
      end

      it 'method list don`t output' do
        expect(tree.list).to_not contain_exactly(nothing)
      end

      it 'method includes? return false' do
        expect(tree.includes?(word: nothing)).to eq(false)
      end
    end

    context 'when we add two-word string' do
      let(:string) { "first second" }
      let(:first_word) { "first" }
      let(:second_word) { "second" }

      before do
        tree.add_string(string: string)
      end

      it 'method list output words which have string' do
        expect(tree.list).to contain_exactly(first_word, second_word)
      end

      it 'method includes? check have thee this words' do
        expect(tree.includes?(word: first_word)).to eq(true)
        expect(tree.includes?(word: second_word)).to eq(true)
      end
    end
  end
end