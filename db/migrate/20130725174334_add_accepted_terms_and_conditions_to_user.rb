class AddAcceptedTermsAndConditionsToUser < ActiveRecord::Migration
  def change
    add_column :users, :accepted_terms_and_conditions, :boolean
  end
end
