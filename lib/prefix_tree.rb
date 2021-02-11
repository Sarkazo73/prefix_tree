require './node'
require './tree'
require 'pry'

tree = Tree.new

loop do
  puts "write the command you want to do. programs have this command: add, add_rec, includes?, includes_rec?, list and end"
  command = gets.chomp!

  case command
  when "add"
    puts "write the word you want to add"
    word = gets.chomp!
    tree.add(word)
  when "add_rec"
    puts "write the word you want to add"
    word = gets.chomp!
    tree.add_rec(word)
  when  "includes?"
    puts "write the word you want to check"
    word = gets.chomp!
    tree.includes?(word)
    if tree.includes?(word)
      puts "tree have this word"
    else
      puts "tree don't have this word"
    end
  when  "includes_rec?"
    puts "write the word you want to check"
    word = gets.chomp!
    if tree.includes_rec?(word)
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

