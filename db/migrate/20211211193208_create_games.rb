class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.string :player_id
      t.datetime :game_date
      t.integer :time_to_win
      t.integer :clicks_to_win

      t.timestamps
    end
  end
end
