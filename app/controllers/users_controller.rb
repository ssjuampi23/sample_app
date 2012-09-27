class UsersController < ApplicationController

  before_filter :signed_in_user, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id]) # takes the id parameter from the requesting page
  end
  
  def new
    @user = User.new #here we creates a new user variable
  end
  
  def edit
    @user = User.find(params[:id])
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
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      #Handle a successful update
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end # end else
  end # end update
  
  private
  
  def signed_in_user
    redirect_to signin_url, notice: "Please sign in. " unless signed_in?
  end
  
end
