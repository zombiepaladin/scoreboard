class CreateAdminActions < ActiveRecord::Migration
  def change
    create_table :admin_actions do |t|
      t.integer :user_id
      t.integer :admin_id
      t.text :description 

      t.timestamps
    end
  end
end
