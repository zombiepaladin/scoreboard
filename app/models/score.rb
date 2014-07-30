class ScoreValidator < ActiveModel::Validator
  def validate(record)
    unless(record.admin_override)
      if(record.task.upcoming?)
        record.errors[:base] << "This challenge has not begun yet."
      end
      if(record.task.expired?)
        record.errors[:base] << "This challenge has expired."
      end
    end
    if(record.user.admin?)
      record.errors[:base] << "Admins can't score points."
    end
    if(record.errors[:task_id].size > 0)
      record.errors[:base] << "You've already completed this challenge."
    end
  end
end

class Score < ActiveRecord::Base
  belongs_to :user
  belongs_to :task
  belongs_to :admin, class_name: 'User'

  validates_presence_of :user, :points
  validates_uniqueness_of :task_id, scope: :user_id, allow_blank: true
  validates_numericality_of :points
  validates_with ScoreValidator
  
  attr_accessible :day, :points, :user, :task, :admin, :approved, as: :admin

  after_save :update_user_scores
  after_create :apply_pyramid_scheme
  
  scope :approved, where(approved: true)
  
  def self.in_category(category)
    joins(:task).where("tasks.category = ?", category)
  end

  def approve!
    self.approved = true
    self.save!
  end

  def deny!
    self.approved = false
    self.save!
  end

  private
  
  def apply_pyramid_scheme
    if(task && task.id && task.pyramid?) 
      task.value += 10
      task.save
      Score.where(task_id: task.id).all.each do |s|
        s.points = task.value
        s.save
        s.user.update_scores!
      end
    end
  end
  
  def update_user_scores
    user.update_scores!
  end
  
  def set_day
    self.day = Time.now.to_date
  end
  
end
