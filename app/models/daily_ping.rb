class DailyPing < ActiveRecord::Base
  attr_accessible :date, :user_id
  belongs_to :user
  validates_uniqueness_of :date, :scope => :user_id
end
