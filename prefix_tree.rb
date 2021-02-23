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
      when "save to zip"
        save_to_zip_file
      when "load from zip"
        load_from_zip_file
      when "delete"
        delete!
      when "end"
        puts "goodbye"
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

  def delete!
    puts "write the word you want to delete"
    word = gets.chomp!
    @tree.delete!(word: word)

    binding.pry

  end

  def save_to_file
    File.open(FILEMANE, 'w') { |file| @tree.list.each { |word| file.write("#{word}\n") } }
  end

  def load_from_file
    @tree.clean_tree

    file_data = File.read(FILEMANE)

    @tree.add_string(string: file_data)
  end

  def save_to_zip_file
    save_to_file

    zip_file = File.new("data/file.zip", 'w')

    Zip::File.open(zip_file.path, Zip::File::CREATE) { |zipfile| zipfile.add('words.txt', File.join(FILEMANE)) }
  end

  def load_from_zip_file
     zip_file = File.new("data/file.zip", 'r')

    File.delete(FILEMANE) if File.exist?(FILEMANE)
    Zip::File.open(zip_file.path, Zip::File) { |zipfile| zipfile.extract('words.txt' , File.join(FILEMANE))}

    load_from_file

  end
end

