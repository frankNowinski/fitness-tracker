class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :username
      t.string  :password_digest
      t.integer :weekly_goal_id
    end
  end
end
