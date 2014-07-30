class RenameUserScores < ActiveRecord::Migration
  def up
    rename_column :users, :score_attendance, :score_be_there
    rename_column :users, :score_puzzle, :score_solve_this
    rename_column :users, :score_crosscurricular, :score_get_schooled
    rename_column :users, :score_cooperation, :score_find_someone
    rename_column :users, :score_story, :score_play_the_book
  end

  def down
    rename_column :users, :score_be_there, :score_attendance
    rename_column :users, :score_solve_this, :score_puzzle
    rename_column :users, :score_get_schooled, :score_crosscurricular
    rename_column :users, :score_find_someone, :score_cooperation
    rename_column :users, :score_play_the_book, :score_story
  end
end
