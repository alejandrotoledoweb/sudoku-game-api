class Game < ApplicationRecord

  has_many :moves

  validates_presence_of :board
  validates_presence_of :solution
end
