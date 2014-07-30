class Tutorial < ActiveRecord::Base
  attr_accessible :youtube_embed
  validates_presence_of :youtube_embed
end
