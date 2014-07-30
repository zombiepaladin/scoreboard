class User < ActiveRecord::Base
  has_many :scores, dependent: :destroy
  has_many :tasks, through: :scores
  has_many :admin_actions
  has_many :daily_pings

  validates_presence_of :eid, :name
  after_create :update_scores!

  scope :admins, where(admin: true)
  scope :players, where(admin: false).where(accepted_terms_and_conditions: true)
  
  def score(category = nil)
    return self[:score] unless category 
    self["score_#{category.underscore}"]
  end

  def milestones
    tasks.where(milestone: true)
  end

  def self.from_auth(auth_hash)
    user = find_by_eid(auth_hash.uid)
    return user if user

    user = User.new do |u|
      u.eid = auth_hash.uid
      u.name = auth_hash.uid # if provider has name, it can be used instead: auth["info"]["name"]
    end
    user.save!
    
    user
  end

  def completed?(task)
    tasks.where(id: task.id).any?
  end
  
  def incomplete_tasks
    complete_task_ids = tasks.collect{|t| t.id}
    Task.all.reject{|t| complete_task_ids.include? t.id}
  end

  def update_scores!
    self.score = scores.approved.sum(:points)
    Task::CATEGORIES.each do |category|
      self["score_#{category.underscore}"] = scores.in_category(category).approved.sum(:points)
    end
    self.save!
  end

  def to_param
    "#{id}-#{eid.underscore.gsub(" ","-").gsub(/[^a-z0-9-]/i,"")}"
  end
end
