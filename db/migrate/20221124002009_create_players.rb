class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.string :name, null: false
      t.integer :age, null: false
      t.string :position, null: false
      t.integer :overall, null: false

      t.timestamps
    end
  end
end
