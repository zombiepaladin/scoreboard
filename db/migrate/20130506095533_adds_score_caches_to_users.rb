class AddsScoreCachesToUsers < ActiveRecord::Migration
  TYPES = %w(attendance puzzle crosscurricular cooperation story)
  def up
    add_column :users, :score, :integer
    add_index :users, :score
    TYPES.each do |type|
      add_column :users, :"score_#{type}", :integer
      add_index :users, :"score_#{type}"
    end
  end

  def down
    TYPES.each do |type|
      remove_index :users, :"score_#{type}"
      remove_column :users, :"score_#{type}"
    end
    remove_index :users, :score
    remove_column :users, :score, :integer
  end
end
