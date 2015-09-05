# class LoginLimit
#   def initialize
#     @last = Time.new
#     @count = 0
#   end

#   def wrong
#     @count += 1
#   end

#   def last=(time)
#     @last = time
#   end

#   def count=(num)
#     @count = num
#   end 


#   attr_reader :last, :count
# end

class SessionsController < ApplicationController
  # limitation = LoginLimit.new
  # before_action do 
  #   unless  session[:limitation]
  #     session[:limitation] = LoginLimit.new   
  #   end
  # end

  before_action do
    unless session[:login_count]
      session[:login_count] = 0
    end
    unless session[:login_time]
      session[:login_time] = Time.new
    end
  end

  def new
    session[:admin_id]=nil
    # if Rails.cache.increment("login/ip/#{request.ip}",  0, expires_in: 10.minutes).to_i > 3
    #   render :limit
    # else
    #   # login form
    #   render :new
    # end

    #用session实现限制登陆功能
    if session[:login_count]>3 && (Time.new - session[:login_time].to_datetime )<2*60
      render :limit
    else
      # login form
      render :new
    end    

  end

  def create
    p session[:login_count]
    p session[:login_time]
    p (Time.new - session[:login_time].to_datetime)
    # session[:admin_id]=nil
    # if admin = Admin.authenticate(params[:username],params[:password])
    #   session[:admin_id] = admin.id
    #   session[:nickname] = admin.nickname
    #   redirect_to "/admin/index" 
    # else
    #   redirect_to login_url,:alert => "无效的用户名或密码"
    # end


    # session[:admin_id]=nil
    # #使用缓存判断是否达到限制次数
    # if Rails.cache.increment("login/ip/#{request.ip}", 1, expires_in: 10.minutes).to_i > 3
    #   #如果达到三次就渲染禁止登录模板
    #   render :limit
    # else
    #   if admin = Admin.authenticate(params[:username],params[:password])
    #     # login
    #     session[:admin_id] = admin.id
    #     session[:nickname] = admin.nickname
    #     redirect_to "/admin/index" 
    #     Rails.cache.delete("login/ip/#{request.ip}")
    #   else
    #     # render :show
    #     redirect_to login_url,:alert => "无效的用户名或密码"
    #   end
    # end

    #使用session判断是否达到限制次数
    if  session[:login_count]>3 && (Time.new - session[:login_time].to_datetime )<2*60
      #如果达到三次就渲染禁止登录模板
      render :limit
    else
      if admin = Admin.authenticate(params[:username],params[:password])
        # login
        session[:admin_id] = admin.id
        session[:nickname] = admin.nickname
        redirect_to "/admin/index" 
        session[:login_count] = 0
        session[:login_time] = Time.new - 10*60
      else
        # render :show
        session[:login_count] += 1
        session[:login_time] = Time.new
        redirect_to login_url,:alert => "无效的用户名或密码"
      end
    end
  end

  def destroy
    session[:admin_id] = nil
    redirect_to posts_url, :notice => "已注销"
  end
end

