require 'sqlite3'
require 'singleton'

class PlayDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('plays.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Play
  attr_accessor :id, :title, :year, :playwright_id

  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM plays")
    data.map { |datum| Play.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @year = options['year']
    @playwright_id = options['playwright_id']
  end

  def create
    raise "#{self} already in database" if self.id
    PlayDBConnection.instance.execute(<<-SQL, self.title, self.year, self.playwright_id)
      INSERT INTO
        plays (title, year, playwright_id)
      VALUES
        (?, ?, ?)
    SQL
    self.id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless self.id
    PlayDBConnection.instance.execute(<<-SQL, self.title, self.year, self.playwright_id, self.id)
      UPDATE
        plays
      SET
        title = ?, year = ?, playwright_id = ?
      WHERE
        id = ?
    SQL
  end

  def self.find_by_title(title)
    find_title = PlayDBConnection.instance.execute(<<-SQL, title)
      SELECT *
      FROM plays
      WHERE title = ?
    SQL
    Play.new(find_title[0])
  end 

  # returns all plays written by playwright
  def self.find_by_playwright(name)
    find_playwright = PlayDBConnection.instance.execute(<<-SQL, name)
      SELECT title
      FROM plays
      JOIN playwrights ON playwrights.id = plays.playwright_id
      WHERE name = ?
    SQL
    Play.new(find_playwright[0])
  end
end

class Playwright 

    attr_accessor :id, :name, :birth_year

  def self.all
    datas = PlayDBConnection.instance.execute(
        "SELECT * 
        FROM playwrights")
    datas.map {|data| Playwright.new(data)}
  end

  def self.find_by_name(name)
    find_name = PlayDBConnection.instance.execute(<<-SQL, name)
        SELECT *
        FROM playwrights
        WHERE name = ?
    SQL
    return nil unless find_name.length > 0
    Playwright.new(find_name[0])
  end

  # initalize method
  def initialize(options)
    @id = options['id']
    @name = options['name']
    @birth_year = options['birth_year']
  end

  def insert
    raise "#{self} already in database" if self.id
    PlayDBConnection.instance.execute(<<-SQL, self.name, self.birth_year)
        INSERT INTO
            playwrights (name, birth_year)
        VALUES
            (?, ?)
    SQL
    self.id = PlayDBConnection.instance.last_insert_row_id
  end

  def self.update
    raise "#{self} not in database" unless self.id
    PlayDBConnection.instance.execute(<<-SQL, self.name, self.birth_year)
        UPDATE
            playwrights
        SET
            name = ?, birth_year = ?
        WHERE
            id = ?
    SQL
  end

  # returns all plays written by playwright
  def get_plays
    all_plays = PlayDBConnection.instance.execute(<<-SQL)
        SELECT title
        FROM plays
        JOIN playwrights ON playwrights.id = plays.id
        WHERE plays.playwright_id = playwrights.id
    SQL
    Playwright.new(all_plays[0])
  end

end
