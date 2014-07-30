class CreateDailyPings < ActiveRecord::Migration
  def change
    create_table :daily_pings do |t|
      t.integer :user_id
      t.date :date

      t.timestamps
    end
  end
end
