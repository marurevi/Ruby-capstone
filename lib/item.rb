require 'securerandom'
require 'date'

class Item
  attr_accessor :genre, :author, :source, :label, :published_date
  attr_reader :id, :archived

  def initialize(published_date, id = SecureRandom.uuid, archived: false)
    @published_date = published_date
    @id = id
    @archived = archived
  end

  def move_to_archive
    @archived = true if can_be_archived?
  end
  
  private

  def can_be_archived?
    @published_date.to_date.year < Date.today.year - 10
  end
end
