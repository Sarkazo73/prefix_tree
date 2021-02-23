require_relative './node'

class Tree

  def initialize
    @root = Node.new
  end

  def clean_tree
    @root.children = []
  end

  def add_string(string:)
    word_array = string.split
    word_array.each { |word| add(word: word) }
  end

  def add(word:, current_node: @root)
    return if word.empty?

    word_end = word.length == 1
    word_tail = word[1..-1]
    first_letter = word[0]
    current_node = current_node.find_or_create_child(letter: first_letter, word_end: word_end)

    add(word: word_tail, current_node: current_node)
  end

  # def add(word)
  #   char_array = word.split("")
  #   word_length = word.length
  #   current_node = @root
  #
  #   char_array.each_with_index do |letter, i|
  #     word_end = i == (word_length - 1)
  #     existing_node = current_node.find_child(letter)
  #
  #     if existing_node.nil?
  #       new_node = current_node.add_child(letter, word_end)
  #       current_node = new_node
  #     else
  #       existing_node.word_end = word_end if word_end
  #       current_node = existing_node
  #     end
  #   end
  # end


  def includes?(word:, current_node: @root)
    existing_node = current_node.find_child(letter: word[0])

    return false if existing_node.nil?
    return existing_node.word_end? if word.length == 1

    includes?(word: word[1..-1], current_node: existing_node)
  end

  # def includes?(word)
  #   char_array = word.split("")
  #   current_node = @root
  #   word_length = word.length
  #
  #   char_array.each_with_index do |letter, i|
  #     existing_node = current_node.find_child(letter)
  #
  #     return false if existing_node.nil?
  #     return existing_node.word_end if i == (word_length - 1)
  #
  #     current_node = existing_node
  #   end
  # end

  def delete!(word:, current_node: @root)
    existing_node = current_node.find_child(letter: word[0])
    return false if existing_node.nil?

    if word.length == 1
      existing_node.word_end = false
      if existing_node.children == []
        current_node.children = current_node.children.reject{ |node| node.value == word[0] }
      end

      return existing_node.children == []
    end

    if delete!(word: word[1..-1], current_node: existing_node)
      existing_node.children = existing_node.children.reject{ |node| node.value == word[0] }
    end

    if existing_node.children == [] && existing_node.word_end == false
      current_node.children = current_node.children.reject{ |node| node.value == word[0] }
    end

    existing_node.children == [] && existing_node.word_end == false
  end

  def list
    @words = []
    assembly
    @words
  end

  private

  def assembly(current_node: @root, word: "")
    word += current_node.value unless current_node.value.nil?
    @words << word if current_node.word_end?

    current_node.children.each { |child| assembly(current_node: child, word: word) }
  end

end

