require 'securerandom'
require 'date'

class Item
  attr_accessor :genre, :author, :source, :label, :published_date, :archived
  attr_reader :id

  def initialize(published_date, id = SecureRandom.uuid)
    @published_date = published_date
    @id = id
    @archived = false
  end

  def move_to_archive
    @archived = true if can_be_archived?
  end

  private

  def can_be_archived?
    @published_date.to_date < Date.today.year - 10
  end
end
