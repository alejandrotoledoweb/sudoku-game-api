class Game < ApplicationRecord

  has_many :moves

  validates_presence_of :board
end
