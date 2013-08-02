class AccessController < ApplicationController
  
  layout 'admin'
  
  before_filter :confirm_logged_in, :only => [:index, :menu]
  
  def index
    menu
    render ('menu')
  end
  
  def menu
    #display text and links
  end

  def login
    #login form
  end
  
  def attempt_login
    authorized_user = AdminUser.authenticate(params[:username], params[:password] ) #gets back a user object, or false
    
    if authorized_user #handstamp
      session[:user_id] = authorized_user.id
      session[:username] = authorized_user.username #stored for convenience, doesnt change alot
      flash[:notice] = "You are now logged in."
      redirect_to(:action => 'menu')
    
    else
      flash[:notice] = "Invalid username/password combination."
      redirect_to(:action => 'login')
    end  
  end
  
  def logout
    #TODO: mark user as logged out
    session[:user_id] = nil
    session[:user_name] = nil
    
    flash[:notice] = "You have been logged out."
    redirect_to(:action => "login")
  end
  
 
  
end
