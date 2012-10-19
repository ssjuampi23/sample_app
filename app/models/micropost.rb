class Micropost < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user # a micropost belongs to an user
  has_many :microposts#an user has many microposts
  
  validates :user_id, presence: true
end
