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

      it 'has value nil and word end false' do
        expect(subject.value).to eq(nil)
        expect(subject.word_end).to eq(false)
      end
    end

    context 'when creates child node with params' do
      subject { node }

      it { is_expected.to have_attributes(children: [], value: node_value, word_end: node_word_end) }
    end
  end

  describe '#add_child' do
    let(:child_value) { Faker::String.rand }
    let(:child_word_end) { Faker::Boolean.rand }

    subject { node.add_child(child_value, child_word_end) }

    it { is_expected.to have_attributes(children: [], value: child_value, word_end: child_word_end) }

    it 'add current node in children array parent node' do
      expect(node.children).to contain_exactly(subject)
    end
  end

  describe '#find_child' do
    let(:child_value) { Faker::String.rand }
    let(:child_word_end) { Faker::Boolean.rand }

    subject { node.find_child(child_value) }

    context 'when children have child node with correct param' do
      let!(:child_node) { node.add_child(child_value, child_word_end) }

      it { is_expected.to eq child_node }
    end

    context 'when children don`t have child node with correct param`' do
      it { is_expected.to be_nil }
    end
  end
end
