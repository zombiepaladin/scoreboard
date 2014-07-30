class AdminAction < ActiveRecord::Base
  attr_accessible :admin, :admin_id, :description, :user, :user_id
  belongs_to :user
  belongs_to :admin, class_name: 'User'
end
