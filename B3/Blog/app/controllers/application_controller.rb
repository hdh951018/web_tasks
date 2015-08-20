class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter do 
    if params[:post_id]!='' && params[:post_id]
      session[:post_id]=params[:post_id]
    end
  end
  protect_from_forgery
  protected
    def authorize
      unless Admin.find_by_id(session[:admin_id])
        redirect_to login_url , :notice => '请登录'
      end
    end 
end
