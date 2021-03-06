class UsersController < ApplicationController

  before_filter :signed_in_user, only: [:index,:edit, :update, :destroy, :following, :followers]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy #all this filters are declared on this same controller
  
  #EXERCISE 9 CHAPTER 9 
  
  #def destroy
    
    #if current_user.admin?
      
    #else
     #  User.find(params[:id]).destroy
      # flash[:success] = "User destroyed"
    #   redirect_to users_url  
    #end  
    
  #end
 
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed"
    redirect_to users_url
  end
  
  def index
    @users = User.paginate(page: params[:page])
    #@users = User.all # @user is a variable that i can name the way i want
  end
  
  def show
    #@accion2 = "set from show" + @accion if !@accion.nil?    
    @user = User.find(params[:id]) # takes the id parameter from the requesting page
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  
 #EXERCISE 6 CHAPTER 9 
 
  def new
    @user = User.new #here we creates a new user variable
    
    if signed_in?
    redirect_to(root_path)
    else
    render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  
  #EXERCISE 6 CHAPTER 9 
  
  def exc_test
    accion = params[:action]
  end
  
  def create
    @user = User.new(params[:user]) # is equivalent to @user = User.new(name: "Foo Bar", email: "foo@invalid", password: "foo", password_confirmation: "bar")
    @accion = "motivation"
    if signed_in?
       redirect_to(root_path)
    else
      if
        @user.save
        sign_in @user
        
        #@accion = params[:action]
        
        
        
        flash[:success] = "Welcome to the Sample App!" #creates the flash variable, the content will be displayed when the user successfully signs up
        redirect_to @user#Handle a successful save
      else
        render 'new'
      end
    end
  end #end create
  
  
  
  
  #visit signup_path # put is used to access the controller action, is the same as visit
      #redirect_to(root_path) 
  
  #ORIGINAL
  #def create
    #@user = User.new(params[:user]) # is equivalent to @user = User.new(name: "Foo Bar", email: "foo@invalid", password: "foo", password_confirmation: "bar")
   # if
    #  @user.save
    #  sign_in @user
    #  flash[:success] = "Welcome to the Sample App!" #creates the flash variable, the content will be displayed when the user successfully signs up
    #  redirect_to @user#Handle a successful save
  #  else
    #  render 'new'
  #  end #end if-else
  #end #end create
  
  
  
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
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow' #the show_follow does not exist currently, therefore we must create it
end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  private
  
  #
 # def signed_in_user
 #   unless signed_in?
  #    store_location
 #     redirect_to signin_url, notice: "Please sign in. "
 #   end
 # end
  
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user) #current_user boolean method defined in sessions_helper
  end
  
  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
  
end
