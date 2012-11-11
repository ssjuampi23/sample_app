class MicropostsController < ApplicationController

 before_filter :signed_in_user, only: [:create, :destroy]
 
 def create
  @micropost = current_user.microposts.build(params[:micropost]) # the @micropost variable is being created here, then it can be reached in the view
  if @micropost.save
    flash[:success] = "Micropost created!"
    redirect_to root_url
  else
    @feed_items = [] #this solvs the problem with the failing spec tests that were failing because failed submissions were not properly handled
    render 'static_pages/home'
  end
 end
 
 def destroy
 end
 
 def index
 end

end