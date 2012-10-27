class StaticPagesController < ApplicationController
  def home
    @micropost = current_user.microposts.build if signed_in?  # this is a micropost instance variable
  end

  def help
  end
  
  def about
  end
  
  def contact
  end
  
end
