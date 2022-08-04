require 'json'

require_relative 'author'
require_relative 'game'
require_relative 'book'
require_relative 'label'
require_relative 'musicalbum'
require_relative 'genre'
require_relative 'loaders'
require_relative 'serializers'

class App
  attr_reader :games, :authors, :books, :labels, :musicalbums, :genres

  include Serializers
  include Loaders

  def initialize
    @authors = File.file?('data/authors.json') ? load('data/authors.json')['authors'] : []
    @genres = File.file?('data/genres.json') ? load('data/genres.json')['genres'] : []
    @labels = File.file?('data/labels.json') ? load('data/labels.json')['labels'] : []
    @games = File.file?('data/games.json') ? load('data/games.json')['games'] : []
    @books = File.file?('data/books.json') ? load('data/books.json')['books'] : []
    @musicalbums = File.file?('data/musicalbums.json') ? load('data/musicalbums.json')['musicalbums'] : []
    @items = [*@games, *@books, *@musicalbums]
    find_items(@authors)
    find_items(@genres)
    find_items(@labels)
  end

  def call_input(first)
    puts "What would you like to do #{first ? 'first' : 'next'}? (1 - 10)"
    puts ''
    puts '1 - List all books'
    puts '2 - List all music albums'
    puts '3 - List of games'
    puts '4 - List all genres'
    puts '5 - List all labels'
    puts '6 - List all authors'
    puts '7 - Add a book'
    puts '8 - Add a music album'
    puts '9 - Add a game'
    puts '10 - Exit'
    gets.chomp.strip
  end

  def cases(command)
    return unless %w[1 2 3 4 5 6 7 8 9].include? command

    { '1' => -> { list_item(@books) },
      '2' => -> { list_item(@musicalbums) },
      '3' => -> { list_item(@games) },
      '4' => -> { list_item(@genres) },
      '5' => -> { list_item(@labels) },
      '6' => -> { list_item(@authors) },
      '7' => -> { add_item('book') },
      '8' => -> { add_item('music album') },
      '9' => -> { add_item('game') } }[command].call
  end

  def action(first)
    command = call_input(first)
    puts ''
    cases(command)
    command
  end

  def run
    puts '============================='
    puts '  Welcome, choose an option  '
    puts '============================='
    command = action(true)
    save(@games, @authors, @books, @labels, @musicalbums, @genres)
    while command != '10'
      puts ' '
      command = action(false)
      save(@games, @authors, @books, @labels, @musicalbums, @genres)
    end
    puts ' '
    puts ' Thank you for using this catalogue... Goodbye!'
  end

  private

  def find_items(objs)
    objs.each do |obj|
      newitems = []
      obj.items.each do |id|
        @items.each do |item|
          newitems << item if id == item.id
        end
      end
      obj.items = []
      newitems.each do |item|
        obj.add_item(item)
      end
    end
  end

  def list_item(items)
    if items.empty?
      puts `There are no items of that type yet!, please add needed items`
      return
    end
    puts "Your catalog contains the following #{items[0].class}s:"
    case items
    when @books, @musicalbums, @games
      items.each.with_index do |item, i|
        puts "#{i + 1}) [#{item.class}] The #{item.genre.name} titled #{item.label.title} by #{item.author.first_name} #{item.author.last_name} was released in #{item.published_date.to_date}."
      end
    when @authors
      @authors.each.with_index do |author, i|
        puts "#{i + 1}) [Author] #{author.first_name} #{author.last_name}"
      end
    when @labels
      @labels.each.with_index do |label, i|
        puts "#{i + 1}) [Label] Title: #{label.title} - Color: #{label.color}"
      end
    when @genres
      @genres.each_with_index do |genre, i|
        puts "#{i + 1}) [Genre] #{genre.name}"
      end
    end
  end

  def retrieve_objects
    inp_genre = [(print 'Genre: '), gets.rstrip][1]
    genre = @genres.find { |g| g.name == inp_genre }
    genre = genre.nil? ? Genre.new(inp_genre) : genre
    inp_author_first = [(print 'Author first name: '), gets.rstrip][1]
    inp_author_last = [(print 'Author last name: '), gets.rstrip][1]
    author = @authors.find { |a| a.first_name == inp_author_first && a.last_name == inp_author_last }
    author = author.nil? ? Author.new(inp_author_first, inp_author_last) : author
    title = [(print 'Title: '), gets.rstrip][1]
    color = [(print 'Color: '), gets.rstrip][1]
    label = @labels.find { |lb| lb.title == title && lb.color == color }
    label = label.nil? ? Label.new(title, color) : label
    [genre, author, label]
  end

  def add_item_to_owner(item, owner, owners)
    owner.add_item(item)
    owners << owner unless owners.include?(owner)
  end

  def add_item(type)
    genre, author, label = retrieve_objects
    inp_published_date = [(print 'Published date (yyyy-mm-dd): '), gets.rstrip][1]
    year, month, day = inp_published_date.split('-')
    published_date = Date.new(year.to_i, month.to_i, day.to_i)
    begin
      case type
      when 'book'
        list = @books
        publisher = [(print 'Publisher: '), gets.rstrip][1]
        cover_state = [(print 'Cover state, (good or bad): '), gets.rstrip][1]
        item = Book.new(published_date, publisher, cover_state)
      when 'music album'
        list = @musicalbums
        on_spotify = [(print 'Is this album on spotify (true or false): '), gets.rstrip.capitalize][1] == 'True'
        item = MusicAlbum.new(published_date, on_spotify: on_spotify)
      when 'game'
        list = @games
        multiplayer = [(print 'Multiplayer: '), gets.rstrip][1]
        inp_last_played_at = [(print 'Last played at (yyyy-mm-dd): '), gets.rstrip][1]
        year1, month1, day1 = inp_last_played_at.split('-')
        last_played_at = Date.new(year1.to_i, month1.to_i, day1.to_i)
        item = Game.new(multiplayer, last_played_at, published_date)
      end
      add_item_to_owner(item, label, @labels)
      add_item_to_owner(item, genre, @genres)
      add_item_to_owner(item, author, @authors)
      puts "#{type.capitalize} added successfully!"
      list << item
    rescue StandardError
      puts "Could not add #{type} with the provided info!"
    end
  end
end
