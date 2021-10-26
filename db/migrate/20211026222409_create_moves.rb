class CreateMoves < ActiveRecord::Migration[6.1]
  def change
    create_table :moves do |t|
      t.references :game, null: false, foreign_key: true
      t.integer :row
      t.integer :col
      t.integer :number

      t.timestamps
    end
  end
end
