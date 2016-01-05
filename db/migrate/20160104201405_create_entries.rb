class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.integer :chest
      t.integer :back
      t.integer :shoulders
      t.integer :arms
      t.integer :legs
      t.integer :cardio
      t.integer :goal_id
    end
  end
end
