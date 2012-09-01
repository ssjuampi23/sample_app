class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id]) # takes the id parameter from the requesting page
  end
  
  def new
  end
end
