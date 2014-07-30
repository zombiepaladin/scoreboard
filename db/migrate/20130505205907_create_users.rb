class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :eid
      t.string :name
      t.string :email
      t.boolean :admin, default: false
      t.boolean :freeze_points, default: false

      t.timestamps
    end
  end
end
