class Move < ApplicationRecord
  belongs_to :game
  
  validates :board, presence: true
  validates :row, presence: true
  validates :column, presence: true
  validates :number, presence: true
end
