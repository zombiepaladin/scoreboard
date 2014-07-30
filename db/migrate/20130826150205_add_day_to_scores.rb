class AddDayToScores < ActiveRecord::Migration
  def change
    add_column :scores, :day, :date

  end
end
