class AddFeedbackToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :feedback, :text
  end
end
