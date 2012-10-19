module SessionsHelper

  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token # internally implements the function that makes the cookie expiring 20 years from now
    self.current_user = user # the current_user is now accesible from both controllers and views, this will allow a better manipulation of the user's data
   
    # self is used to make the current_user object accesible from a global point of view (controllers and views)
    #self.current_user =... this code is automatically converted to current_user=(user)
  end
  
  def signed_in?
    !current_user.nil? # if the current_user is not nil it means that it is signed in
  end
  
  def current_user=(user)
    @current_user = user # @current_user is a variable that stores the user object for later use
  end
  
  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token]) # 
  end
  
  def current_user?(user)
    user == current_user 
  end
  
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token) 
  end
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
     #it redirects to the desired URI if it exists, otherwise will redirect to the default URI
    session.delete(:return_to) #removes the forwarding URI
  end
  
  def store_location
    session[:return_to] = request.url
  end
  

  
end
