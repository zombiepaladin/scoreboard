class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.integer :value
      t.date :starts_on
      t.date :ends_on
      t.string :category
      t.boolean :milestone
      t.integer :bonus
      t.text :solution
      t.string :token

      t.timestamps
    end
  end
end
