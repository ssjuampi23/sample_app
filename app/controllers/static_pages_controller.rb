class StaticPagesController < ApplicationController
  
  def home
    if signed_in?
      @micropost = current_user.microposts.build # this is a micropost instance variable
      @feed_items = current_user.feed.paginate(page: params[:page]) # this is a feed instance variable
    end
    #@micropost = current_user.microposts.build if signed_in?  # this is a micropost instance variable
  end

  def help
  end
  
  def about
  end
  
  def contact
  end
  
end
