class Micropost < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user # a micropost belongs to an user
  
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 140}
  
  
  default_scope order: 'microposts.created_at DESC' # DESC means descending (from newest to older) which is a SQL syntax
                                                    #default scope also gets the "should have the right microposts in the right order" test to pass
                                                    
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user.id) # Returns microposts from the users being followed by the given user.
    #where("user_id IN ?) OR user_id = ?", followed_user_ids, user)
  end                                                    
                                                    
end
