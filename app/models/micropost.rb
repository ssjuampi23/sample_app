class Micropost < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user # a micropost belongs to an user
  
  validates :user_id, presence: true
end
