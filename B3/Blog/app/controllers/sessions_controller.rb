class SessionsController < ApplicationController
  # skip_before_filter :authorize
  def new
    session[:admin_id]=nil
  end

  def create
    session[:admin_id]=nil
    if admin = Admin.authenticate(params[:username],params[:password])
      session[:admin_id] = admin.id
      session[:nickname] = admin.nickname
      redirect_to "/admin/index" 
    else
      redirect_to login_url,:alert => "无效的用户名或密码"
    end
  end

  def destroy
    session[:admin_id] = nil
    redirect_to posts_url, :notice => "已注销"
  end
end
