require './lib/node'
require './lib/tree'
require 'pry'

tree = Tree.new

loop do
  puts "write the command you want to do. programs have this command: add, includes?, list and end"
  command = gets.chomp!

  case command
  when "add"
    puts "write the word you want to add"
    string = gets.chomp!
    tree.add_string(string: string)
  when  "includes?"
    puts "write the word you want to check"
    word = gets.chomp!
    tree.includes?(word: word)
    if tree.includes?(word: word)
      puts "tree have this word"
    else
      puts "tree don't have this word"
    end
  when  "list"
    puts tree.list
  when "end"
    break
  else
    puts "program don't have this command"
  end
end

