require 'digest/hmac'
require 'encryptor'

class Task < ActiveRecord::Base
  CATEGORIES = %w(BeThere SolveThis GetSchooled FindSomeone PlayTheBook)
  
  has_many :scores, dependent: :destroy
  has_many :users, through: :scores
  
  acts_as_list
  attr_accessible :name, :description, :value, :starts_on, :ends_on, :category, :milestone, :pyramid, :bonus, :solution, :icon, :feedback

  validates_presence_of :name, :description, :value, :category, allow_blank: false
  validates_presence_of :bonus, :icon, if: :milestone?
  validates_inclusion_of :category, in: CATEGORIES

  scope :active, where("(starts_on IS NULL OR starts_on <= ?) AND (ends_on IS NULL OR ends_on >= ?)", Date.today, Date.today)
  mount_uploader :icon, MilestoneIconUploader

  before_validation :generate_token

  def active?
    !upcoming? && !expired?
  end

  def upcoming?
    starts_on? && Date.today < starts_on
  end

  def expired?
    ends_on? && Date.today > ends_on
  end

  def complete!(user)
    points = self.value
    points += self.bonus if milestone? && scores.count < 10
    score = Score.new({task: self, user: user, points: points, day: Date.today, approved: !user.freeze_points?}, as: :admin)
  end

  def to_param
    "#{id}-#{name.underscore.gsub(" ","-").gsub(/[^a-z0-9-]/i,"")}"
  end

  def signature
    Digest::HMAC.hexdigest(id.to_s, "--#{Rails.application.config.secret_token}--ready?", Digest::SHA1)
  end

  def encrypted_package_for(user)
    Encryptor.encrypt [token, user.id].join(",")
  end

  def generate_token
    self.token ||= SecureRandom.hex(20)
  end
end
