class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id]) # takes the id parameter from the requesting page
  end
  
  def new
    @user = User.new #here we creates a new user variable
  end
end
