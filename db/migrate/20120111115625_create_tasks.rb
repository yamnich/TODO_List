class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.string :state
      t.string :priority
      t.integer :user_id

      t.timestamps
    end
  end
end
