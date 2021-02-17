# frozen_string_literal: true

require_relative '../lib/node'
require 'faker'

RSpec.describe Node do
  let(:node_value) { Faker::String.rand }
  let(:node_word_end) { Faker::Boolean.rand }
  let(:node) { described_class.new(value: node_value, word_end: node_word_end) }

  describe '.new' do
    context 'when creates root node without params' do
      subject { described_class.new }

      it 'value nil and word end false' do
        expect(subject.value).to eq(nil)
        expect(subject.word_end).to eq(false)
      end
    end

    context 'when creates child node with params' do
      subject { node }

      it { is_expected.to have_attributes(children: [], value: node_value, word_end: node_word_end) }
    end
  end

  describe '#find_or_create_child' do
    let(:child_value) { Faker::String.rand }
    let(:child_word_end) { Faker::Boolean.rand }

    subject { node.find_or_create_child(letter: child_value,word_end: child_word_end) }

    context 'when tree doesn`t have node with this value' do

      it 'when we add new node in array children' do
        expect{subject}.to change{node.children.size}.by(1)
      end

      it { is_expected.to have_attributes(children: [], value: child_value, word_end: child_word_end) }
    end

    context 'when tree have node with this value' do

      context 'when node have with word end param equal false, but we pass true' do
        let!(:child_node) { node.find_or_create_child(letter: child_value,word_end: false ) }
        let(:child_word_end) { true }

        it 'we change word end on true' do
          expect{subject}.to_not change{node.children.size}
          expect(child_node.word_end).to eq true
        end
      end

      context 'when node have with word end param equal true, but we pass false' do
        let!(:child_node) { node.find_or_create_child(letter: child_value,word_end: true) }
        let(:child_word_end) { false }

        it 'we doesn`t change word end on false' do
          expect{subject}.to_not change{node.children.size}
          expect(child_node.word_end).to eq true
        end
      end
    end
  end

  describe '#find_child' do
    let(:child_value) { Faker::String.rand }
    let(:child_word_end) { Faker::Boolean.rand }

    subject { node.find_child(letter: child_value) }

    context 'when children have child node with correct param' do
      let!(:child_node) { node.find_or_create_child(letter: child_value,word_end: child_word_end) }

      it { is_expected.to eq child_node }
    end

    context 'when children don`t have child node with correct param`' do
      it { is_expected.to be_nil }
    end
  end
end
