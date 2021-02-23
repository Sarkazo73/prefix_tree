# frozen_string_literal: true

require_relative '../prefix_tree'

RSpec.describe PrefixTree do
  describe '#call' do
    let(:tree) { Tree.new }
    let(:prefix_tree) { described_class.new }

    before do
      allow(Tree).to receive(:new).and_return(tree)
    end

    context 'when we input "add" in variable "command"' do

      before do
        expect(prefix_tree).to receive_message_chain(:gets, :chomp!).and_return('add')
        expect(prefix_tree).to receive(:loop) do |&block|
          block.call
        end
      end

      it 'call add' do
        expect(prefix_tree).to receive(:add)
        expect{ prefix_tree.call }.to output("write the command you want to do. programs have this command: add, includes?, list and end\n").to_stdout
      end
    end

    context 'when we input "include?" in variable "command"' do

      before do
        expect(prefix_tree).to receive_message_chain(:gets, :chomp!).and_return('includes?')
        expect(prefix_tree).to receive(:loop) do |&block|
          block.call
        end
      end

      it 'call includes?' do
        expect(prefix_tree).to receive(:includes?)
        expect{ prefix_tree.call }.to output("write the command you want to do. programs have this command: add, includes?, list and end\n").to_stdout
      end
    end

    context 'when we input "list" in variable "command"' do

      before do
        expect(prefix_tree).to receive_message_chain(:gets, :chomp!).and_return('list')
        expect(prefix_tree).to receive(:loop) do |&block|
          block.call
        end
      end

      it 'call list' do
        expect(tree).to receive(:list)
        prefix_tree.call
      end
    end

    context 'when we input "file save" in variable "command"' do
      before do
        expect(prefix_tree).to receive_message_chain(:gets, :chomp!).and_return('file save')
        expect(prefix_tree).to receive(:loop) do |&block|
          block.call
        end
      end

      it 'call add' do
        expect(prefix_tree).to receive(:save_to_file)
        expect{ prefix_tree.call }.to output("write the command you want to do. programs have this command: add, includes?, list and end\n").to_stdout
      end
    end

    context 'when we input "file load" in variable "command"' do
      before do
        expect(prefix_tree).to receive_message_chain(:gets, :chomp!).and_return('file load')
        expect(prefix_tree).to receive(:loop) do |&block|
          block.call
        end
      end

      it 'call add' do
        expect(prefix_tree).to receive(:load_from_file)
        expect{ prefix_tree.call }.to output("write the command you want to do. programs have this command: add, includes?, list and end\n").to_stdout
      end
    end

    context 'when we input "save to zip" in variable "command"' do
      before do
        expect(prefix_tree).to receive_message_chain(:gets, :chomp!).and_return('save to zip')
        expect(prefix_tree).to receive(:loop) do |&block|
          block.call
        end
      end

      it 'call add' do
        expect(prefix_tree).to receive(:save_to_zip_file)
        expect{ prefix_tree.call }.to output("write the command you want to do. programs have this command: add, includes?, list and end\n").to_stdout
      end
    end

    context 'when we input "load from zip" in variable "command"' do
      before do
        expect(prefix_tree).to receive_message_chain(:gets, :chomp!).and_return('load from zip')
        expect(prefix_tree).to receive(:loop) do |&block|
          block.call
        end
      end

      it 'call add' do
        expect(prefix_tree).to receive(:load_from_zip_file)
        expect{ prefix_tree.call }.to output("write the command you want to do. programs have this command: add, includes?, list and end\n").to_stdout
      end
    end

    context 'when we input "end" in variable "command"' do

      before do
        expect(prefix_tree).to receive_message_chain(:gets, :chomp!).and_return('end')
      end

      it 'check output' do
        expect{ prefix_tree.call }.to output("write the command you want to do. programs have this command: add, includes?, list and end\ngoodbye\n").to_stdout
      end
    end

    context 'when we input another string in variable "command"' do

      before do
        expect(prefix_tree).to receive_message_chain(:gets, :chomp!).and_return('qwert')
        expect(prefix_tree).to receive(:loop) do |&block|
          block.call
        end
      end

      it 'check output' do
        expect{ prefix_tree.call }.to output("write the command you want to do. programs have this command: add, includes?, list and end\nprogram don't have this command\n").to_stdout
      end
    end
  end

  describe '#add' do
    let(:tree) { Tree.new }
    let(:prefix_tree) { described_class.new }

    before do
      allow(Tree).to receive(:new).and_return(tree)
    end

    context 'when we input correct string in method add' do

      before do
        expect(prefix_tree).to receive_message_chain(:gets, :chomp!).and_return("qwert")
      end

      it 'call add_string method' do
        expect(tree).to receive(:add_string).with(string: "qwert")
        prefix_tree.add
      end
    end

    context 'when we input not correct string in method add' do

      before do
        expect(prefix_tree).to receive_message_chain(:gets, :chomp!).and_return('   qws 1233    ')
        expect(prefix_tree).to receive(:loop) do |&block|
          block.call
        end
      end

      it 'output string' do
        expect{ prefix_tree.add }.to output("write the word you want to add\nplease, write only english words and space\n").to_stdout
      end
    end
  end

  describe '#includes?' do
    let(:word) { "qwert" }
    let(:tree) { Tree.new }
    let(:prefix_tree) { described_class.new }

    before do
      allow(Tree).to receive(:new).and_return(tree)
    end

    context 'when we input word which tree have in method includes?' do

      before do
        expect(prefix_tree).to receive_message_chain(:gets, :chomp!).and_return(word)
        allow(tree).to receive(:includes?).with(word: word).and_return(true)
      end

      it 'output string' do
        expect{ prefix_tree.includes? }.to output("write the word you want to check\ntree have this word\n").to_stdout
      end
    end

    context 'when we input word which tree don`t have in method includes?' do

      before do
        expect(prefix_tree).to receive_message_chain(:gets, :chomp!).and_return(word)
        allow(tree).to receive(:includes?).with(word: word).and_return(false)
      end

      it 'output string' do
        expect{ prefix_tree.includes? }.to output("write the word you want to check\ntree don't have this word\n").to_stdout
      end
    end
  end

  describe '#save_to_file' do
    let(:array_words) { ["qwer", "asdf", "zxcv"] }
    let(:tree) { Tree.new }
    let(:filename) { "data/words.txt" }
    let(:prefix_tree) { described_class.new }


    before do
      allow(Tree).to receive(:new).and_return(tree)
      allow(tree).to receive(:list).and_return(array_words)
    end

    it '' do
      prefix_tree.save_to_file

      expect(File.open(filename, 'r').read).to eq("qwer\nasdf\nzxcv\n")
    end
  end

  describe '#load_from_file' do
    let(:array_words) { "qwer\nasdf\nzxcv\n" }
    let(:tree) { Tree.new }
    let(:filename) { "data/words.txt" }
    let(:prefix_tree) { described_class.new }


    before do
      allow(Tree).to receive(:new).and_return(tree)
      allow(File).to receive(:read).and_return(array_words)
    end

    it '' do
      expect(tree).to receive(:add_string).with(string: array_words)

      prefix_tree.load_from_file
    end
  end

  describe '#save_to_zip_file and #load_from_zip_file' do
    let(:tree) { Tree.new }
    let(:array_words) { "qwer asdf zxcv" }
    let(:first_word) { "qwer"}
    let(:second_word) { "asdf"}
    let(:third_word) { "zxcv"}
    let(:prefix_tree) { described_class.new }

    before do
      allow(Tree).to receive(:new).and_return(tree)
      allow(prefix_tree).to receive_message_chain(:gets, :chomp!).and_return(array_words)
    end

    it '' do
      prefix_tree.add
      prefix_tree.save_to_zip_file
      tree.add_string(string: "test")
      prefix_tree.load_from_zip_file

      expect(tree.list).to contain_exactly(first_word, second_word, third_word)
    end
  end
end