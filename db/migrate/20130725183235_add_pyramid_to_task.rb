class AddPyramidToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :pyramid, :boolean
  end
end
