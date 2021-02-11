require './node'

class Tree

  def initialize
    @root = Node.new
  end

  def add(word)
    char_array = word.split("")
    word_length = word.length
    current_node = @root

    char_array.each_with_index do |letter, i|
      word_end = i == (word_length - 1)
      existing_node = current_node.find_child(letter)

      if existing_node.nil?
        new_node = current_node.add_child(letter, word_end)
        current_node = new_node
      else
        existing_node.word_end = word_end if word_end
        current_node = existing_node
      end
    end
  end

  def add_rec(word, current_node = @root)
    return if word.empty?

    word_end = word.length == 1
    word_tail = word[1..-1]
    first_letter = word[0]
    node = current_node.find_child(first_letter)

    if node.nil?
      node = current_node.add_child(first_letter, word_end)
    else
      node.word_end = word_end if word_end
    end

    add_rec(word_tail, node)
  end

  def includes?(word)
    char_array = word.split("")
    current_node = @root
    word_length = word.length

    char_array.each_with_index do |letter, i|
      existing_node = current_node.find_child(letter)

      return false if existing_node.nil?
      return existing_node.word_end if i == (word_length - 1)

      current_node = existing_node
    end
  end

  def includes_rec?(word, current_node = @root)
    existing_node = current_node.find_child(word[0])

    return false if existing_node.nil?
    return existing_node.word_end? if word.length == 1

    includes_rec?(existing_node, word[1..-1])
  end

  def list
    @words = []
    assembly(@root)
    @words
  end

  def assembly(current_node, n = "")
    n += current_node.value unless current_node.value.nil?
    @words << n if current_node.word_end?

    current_node.children.each { |child| assembly(child, n) }
  end


end
