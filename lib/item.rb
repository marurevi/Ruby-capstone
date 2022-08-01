require 'securerandom'

class Item
  attr_reader :id
  
  def initialize(id = SecureRandom.uuid)
    @id = id
  end
end