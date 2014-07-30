class AddAdminOverrideToScores < ActiveRecord::Migration
  def change
    add_column :scores, :admin_override, :boolean
  end
end
