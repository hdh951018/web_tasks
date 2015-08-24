class SessionsController < ApplicationController
  # skip_before_filter :authorize
  def new
    session[:admin_id]=nil
    if Rails.cache.increment("login/ip/#{request.ip}",  0, expires_in: 10.minutes).to_i > 3
      render :limit
    else
      # login form
      render :new
    end
  end

  def create
    # session[:admin_id]=nil
    # if admin = Admin.authenticate(params[:username],params[:password])
    #   session[:admin_id] = admin.id
    #   session[:nickname] = admin.nickname
    #   redirect_to "/admin/index" 
    # else
    #   redirect_to login_url,:alert => "无效的用户名或密码"
    # end
    session[:admin_id]=nil
    #使用缓存判断是否达到限制次数
    if Rails.cache.increment("login/ip/#{request.ip}", 1, expires_in: 10.minutes) > 3
      #如果达到三次就渲染禁止登录模板
      render :limit
    else
      if admin = Admin.authenticate(params[:username],params[:password])
        # login
        session[:admin_id] = admin.id
        session[:nickname] = admin.nickname
        redirect_to "/admin/index" 
        Rails.cache.delete("login/ip/#{request.ip}")
      else
        # render :show
        redirect_to login_url,:alert => "无效的用户名或密码"
      end
    end
  end

  def destroy
    session[:admin_id] = nil
    redirect_to posts_url, :notice => "已注销"
  end
end
