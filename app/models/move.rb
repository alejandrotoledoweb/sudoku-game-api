class Move < ApplicationRecord
  belongs_to :game
  
  validates :board, presence: true, numericality: { only_integer: true }

  validates :row, presence: true, numericality: { only_integer: true }

  validates :column, presence: true, numericality: { only_integer: true }

  validates :number, presence: true, numericality: { only_integer: true }
  
end
