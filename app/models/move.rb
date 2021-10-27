class Move < ApplicationRecord
  belongs_to :game
  
  validates :game_id, presence: true, numericality: { only_integer: true } 

  validates :row, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, ess_than_or_equal_to: 8 }

  validates :col, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, ess_than_or_equal_to: 8 }

  validates :number, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, ess_than_or_equal_to: 9 }

end
