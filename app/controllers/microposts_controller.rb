class MicropostsController < ApplicationController

 before_filter :signed_in_user, only: [:create, :destroy]
 before_filter :correct_user, only: :destroy #the correct_user was defined on this same controller
 
 def create
  @micropost = current_user.microposts.build(params[:micropost]) # the @micropost variable is being created here, then it can be reached in the view
  if @micropost.save
    flash[:success] = "Micropost created!"
    redirect_to root_url
  else
    @feed_items = [] #this solves the problem with the failing spec tests that were failing because failed submissions were not properly handled
    render 'static_pages/home'
  end
 end
 
 def destroy
   @micropost.destroy
   redirect_to root_url
 end
 
 def index
 end
 
 private
 
 def correct_user
   @micropost = current_user.microposts.find_by_id(params[:id]) # the microposts are found through the association
   redirect_to root_url if @micropost.nil?
 end

end