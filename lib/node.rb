# frozen_string_literal: true

# Description/Explanation of Node class
class Node
  attr_accessor :value, :children, :word_end

  def initialize(value: nil, word_end: false)
    @children = []
    @value = value
    @word_end = word_end
  end

  def find_or_create_child(letter:, word_end:)
    node = find_child(letter: letter)
    if node.nil?
      add_child(letter: letter, word_end: word_end)
    else
      node.word_end = word_end if word_end
      node
    end
  end

  def find_child(letter:)
    @children.find { |child| letter == child.value }
  end

  def word_end?
    @word_end
  end

  private

  def add_child(letter:, word_end:)
    new_node = Node.new(value: letter, word_end: word_end)
    @children << new_node
    new_node
  end
end
