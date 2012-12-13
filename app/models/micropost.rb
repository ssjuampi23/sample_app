class Micropost < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user # a micropost belongs to an user
  
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 140}
  
  
  default_scope order: 'microposts.created_at DESC' # DESC means descending (from newest to older) which is a SQL syntax
                                                    #default scope also gets the "should have the right microposts in the right order" test to pass
                                                    
  def self.from_users_followed_by(user)
    followed_user_ids = user.followed_user_ids #user.followed_user_ids will return an array containing all the IDS of the users the user (parameter) is following
    where("user_id IN (?) OR user_id = ?", followed_user_ids, user)
  end                                                    
                                                    
end
