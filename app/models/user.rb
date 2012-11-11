# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  #attr_accessible :email, :name, :password, :password_confirmation #note that the variable 'admin' is not present in here
  #attr_accessible :email, :name, :password, :password_confirmation, :admin 
  attr_accessible :email, :name, :password, :password_confirmation #note that the variable 'admin' is not present in here
  
  has_secure_password
  
  has_many :microposts, dependent: :destroy 
  #has_many :microposts, dependent: :destroy #has_many :microposts verifies the existence of a microposts attribute
                                            #dependent: :destroy arranges for the dependent microposdts to be destroyed when the user itself is destroyed
  
  #before_save { |user| user.email = email.downcase } #returns a copy of the str with all lowercase letters
  before_save { self.email.downcase! } # it becomes the e-mail insensitive so that is why the test of ht e mixed case passes
  before_save :create_remember_token
  
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6}
  validates :password_confirmation, presence: true
  
  def feed
    #This is preliminary. See "Following users" for the full implementation.
    Micropost.where("user_id = ?", id)
  end
  
  private 
  
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
  
end
