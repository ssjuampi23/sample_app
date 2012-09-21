class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id]) # takes the id parameter from the requesting page
  end
  
  def new
    @user = User.new #here we creates a new user variable
  end
  
  def create
    @user = User.new(params[:user]) # is equivalent to @user = User.new(name: "Foo Bar", email: "foo@invalid", password: "foo", password_confirmation: "bar")
    if
      @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!" #creates the flash variable, the content will be displayed when the user successfully signs up
      redirect_to @user#Handle a successful save
    else
      render 'new'
    end #end if-else
  end #end create
  
end
