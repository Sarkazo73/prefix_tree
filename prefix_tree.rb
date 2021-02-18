require './lib/node'
require './lib/tree'
require 'pry'
require 'zip'

class PrefixTree
  FILEMANE = "data/words.txt"

  def initialize
    @tree = Tree.new
  end

  def call

    loop do
      puts "write the command you want to do. programs have this command: add, includes?, list and end"
      command = gets.chomp!

      case command
      when "add"
        add
      when  "includes?"
        includes?
      when  "list"
        puts @tree.list
      when "file save"
        save_to_file
      when "file load"
        load_from_file
      when "end"
        puts "good by"
        break
      else
        puts "program don't have this command"
      end
    end
  end

  def add
    puts "write the word you want to add"
    loop do
      string = gets.chomp!
      if string.match?(/^[a-z ]+$/) && !string.split.empty?
        @tree.add_string(string: string)
        break
      else
        puts "please, write only english words and space"
      end
    end
  end

  def includes?
    puts "write the word you want to check"
    word = gets.chomp!

    if @tree.includes?(word: word)
      puts "tree have this word"
    else
      puts "tree don't have this word"
    end
  end

  def save_to_file
    File.open(FILEMANE, 'w') { |file| @tree.list.each { |word| file.write("#{word}\n") } }
  end

  def load_from_file
    file_data = File.read(FILEMANE)

    @tree.add_string(string: file_data)
  end

  def save_to_zip_file

    Zip::File.open("data/file_zip", Zip::File::CREATE) { |zipfile| zipfile.add(FILEMANE, File.join(FILEMANE)) }

  end

end

 PrefixTree.new.call
