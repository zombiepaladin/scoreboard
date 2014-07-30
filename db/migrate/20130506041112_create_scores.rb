class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.belongs_to :user
      t.belongs_to :task
      t.integer :points
      t.boolean :approved, default: true
      t.belongs_to :admin

      t.timestamps
    end
    add_index :scores, :user_id
    add_index :scores, :task_id
    add_index :scores, :admin_id
  end
end
