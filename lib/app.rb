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
  attr_reader :games, :authors

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

    { '1' => -> { list_books },
      '2' => -> { list_musicalbum },
      '3' => -> { list_games },
      '4' => -> { list_genre },
      '5' => -> { list_labels },
      '6' => -> { list_authors },
      '7' => -> { add_book },
      '8' => -> { create_musicalbum },
      '9' => -> { add_game } }[command].call
  end

  def action(first)
    command = call_input(first)
    cases(command)
    command
  end

  def run
    puts 'Welcome, choose an option'
    command = action(true)
    save(@games, @authors, @books, @labels, @musicalbums, @genres)
    while command != '10'
      puts ' '
      command = action(false)
      save(@games, @authors, @books, @labels, @musicalbums, @genres)
    end
    puts ' '
    puts 'Leaving the catalogue... Goodbye!'
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

  def list_games
    if @games.empty?
      puts 'There are no games yet!'
      return
    end
    @games.each.with_index do |game, i|
      puts "#{i}) [Game] The #{game.genre} game by #{game.author.first_name} was released in #{game.published_date.to_date}."
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

  def add_game
    genre, author, label = retrieve_objects
    published_date = [(print 'Published date (yyyy-mm-dd): '), gets.rstrip][1]
    year, month, day = published_date.split('-')
    multiplayer = [(print 'Multiplayer: '), gets.rstrip][1]
    last_played_at = [(print 'Last played at (yyyy-mm-dd): '), gets.rstrip][1]
    year1, month1, day1 = last_played_at.split('-')
    begin
      game = Game.new(multiplayer, DateTime.new(year1.to_i, month1.to_i, day1.to_i),
                      DateTime.new(year.to_i, month.to_i, day.to_i))
      author.add_item(game)
      @authors << author unless @authors.include?(author)
      label.add_item(game)
      @labels << label unless @labels.include?(label)
      game.genre = genre
    rescue StandardError
      puts 'Could not create game with provided info!'
      return
    end
    puts 'Game created successfully!'
    @games << game
  end

  def list_authors
    if @authors.empty?
      puts 'There are no authors yet!'
      return
    end
    @authors.each.with_index do |author, i|
      puts "#{i}) [Author] The author is #{author}."
    end
  end

  def list_books
    if @books.empty?
      puts 'There are no books yet!'
      return
    end
    @books.each.with_index do |bk, i|
      puts "#{i}) [Book] The #{bk.genre} book by #{bk.author.first_name} was released in #{bk.published_date.to_date}."
    end
  end

  def add_book
    genre, author, label = retrieve_objects
    published_date = [(print 'Published date (yyyy-mm-dd): '), gets.rstrip][1]
    year, month, day = published_date.split('-')
    cover_state = [(print 'Cover state, (good or bad): '), gets.rstrip][1]
    begin
      book = Book.new(Date.new(year.to_i, month.to_i, day.to_i), cover_state)
      author.add_item(book)
      @authors << author unless @authors.include?(author)
      label.add_item(book)
      @labels << label unless @labels.include?(label)
      book.genre = genre
    rescue StandardError
      puts 'Could not create book with provided info!'
      return
    end
    puts 'Book created successfully!'
    @books << book
  end

  def list_labels
    if @labels.empty?
      puts 'There are no labels yet!'
      return
    end
    @labels.each.with_index do |label, i|
      puts "#{i}) [Label] The label correspond to #{label.title} whith color #{label.color}."
    end
  end

  def list_musicalbum
    if @musicalbums.length.zero?
      puts 'No Music Album added yet !'
    else
      @musicalbums.each_with_index do |album, index|
        puts "#{index + 1} Music Album : #{album.published_date.to_date}"
      end
    end
  end

  def list_genre
    if @genres.length.zero?
      puts 'No Genre registered yet!'
    else
      @genres.each_with_index do |genre, index|
        puts "#{index + 1}) Genre : #{genre}"
      end
    end
  end

  def create_musicalbum
    genre, author, label = retrieve_objects
    published_date = [(print 'Published date (yyyy-mm-dd): '), gets.rstrip][1]
    year, month, day = published_date.split('-')
    on_spotify = [(print 'Is this album on spotify (Type True or False): '), gets.rstrip][1] == 'True'
    begin
      musicalbum = MusicAlbum.new(Date.new(year.to_i, month.to_i, day.to_i), on_spotify: on_spotify)
      author.add_item(musicalbum)
      @authors << author unless @authors.include?(author)
      genre.add_item(musicalbum)
      @genres << genre unless @genres.include?(genre)
      musicalbum.label = label
    rescue StandardError
      puts 'Could not create musicalbum with provided info!'
      return
    end
    puts 'Music Album successfully added !'
    @musicalbums << musicalbum
  end
end
