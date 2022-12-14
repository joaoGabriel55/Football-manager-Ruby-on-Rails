# frozen_string_literal: true

class CreateTeams < ActiveRecord::Migration[6.1]
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.integer :foundation, null: false
      t.string :stadium, null: false

      t.timestamps
    end
  end
end
