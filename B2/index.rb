require 'sinatra'
require 'erb'
require 'active_record'
require 'mysql2'
require './MessageManage.rb'
require './UserManage.rb'
require 'sass'

manager = MsgManager.new
usermgr = UsrManager.new
after { ActiveRecord::Base.connection.close }   #及时断开数据库连接，避免拥堵导致超时
use Rack::Session::Pool, :expire_after => 60*2   #设置Session超时2分钟
enable :sessions

get '/' do
  redirect to '/signin' unless session[:admin]==true  #判断是否已经登陆，未登录则跳转到登录页面，下同
  @query_msg = Message.order(:create_time)
  if params[:query]==''
    @query_msg = Message.order(:create_time)
  elsif params[:mode]=="id" 
    temp_array = Array.new
    if (temp=manager.query_by_id(params[:query].strip))!=nil 
      temp_array.push(temp)
    end
    @query_msg = temp_array
  elsif params[:mode]=="username" 
    @query_msg = manager.query_by_user(params[:query].strip)  
  else
    return erb :index
  end
  erb :index
end

get '/add' do 
  redirect to '/signin' unless session[:admin]==true
  erb :add
end

post '/add' do
  return redirect to ('/') if params[:addCncl] == '取消'
  begin
    manager.add(params[:new_content], session[:id]) 
    redirect to ('/')
  rescue Exception => e
    @message = {status: 'danger', desc: e.message }
    erb :add
  end
end

get '/:username/delete/:id'  do
  redirect to '/signin' unless session[:admin]==true
  if manager.query_by_id(params[:id])==nil ||
    manager.query_by_id(params[:id]).user_id != session[:id] #确定是当前用户的留言，否则不予操作，下同
    return '404 <br>NOT FOUND'  
  end  
  manager.delete(params[:id])
  if params[:username] == 'index'             #在主页删除时返回主页，在个人信息删除时返回到个人信息，下同
    erb :deleted
  else
    redirect to ("/#{params[:username]}")     #直接删除，暂无反馈
  end
end

get '/:username/edit/:id'  do
  redirect to '/signin' unless session[:admin]==true
  @editID = params[:id]
  if manager.query_by_id(params[:id])==nil ||
    manager.query_by_id(params[:id]).user_id != session[:id]
    return '404 <br>NOT FOUND'  
  end
  msg_need_edit = manager.query_by_id(params[:id])
  @origin_msg = msg_need_edit.msg
  erb :edit
end

post '/:username/edit/:id' do
  return redirect to ("/#{params[:username]}") if params[:editCncl] == '取消'
  begin
    manager.edit(params[:id], params[:editContent]) 
    if params[:username] == 'index'
      redirect to '/'
    else
      redirect to ("/#{params[:username]}")
    end
  rescue Exception => e
    @editID = params[:id]
    @message = {status: 'danger', desc: e.message }
    @origin_msg = params[:editContent]
    erb :edit
  end
end

get '/signup' do 
  session[:admin] = false     #注册时关闭session，以免 注册后跳转登录页面 会直接登录原账号
  erb :signup
end

post '/signup' do
  return redirect to ('/') if params[:regCncl] == '取消'
  begin
    usermgr.signup(params[:new_username], params[:new_password],params[:new_password2]) 
    redirect to ('/signin')
  rescue Exception => e
    @message = {status: 'danger', desc: e.message }
    erb :signup
  end
end

get '/signin' do
  redirect to '/' if session[:admin]==true
  erb :signin
end

post '/signin' do
  begin
    temp = usermgr.signin(params[:login_account],params[:login_password])
    session[:id] = temp.id
    session[:username] = temp.username
    session[:admin] = true
    redirect to '/'
  rescue Exception => e
    @message = {status: 'danger', desc: e.message }
    erb :signin
  end
end

get '/:username' do
  redirect to '/signin' unless session[:admin]==true
  @query_msg = manager.query_by_user(session[:username].strip)
  erb :info
end

get '/:username/alterpassword' do
  redirect to '/signin' unless session[:admin]==true
  erb :alter
end

post '/:username/alterpassword' do
  return redirect to ("/#{session[:username]}") if params[:altCncl] == '取消'
  begin
    usermgr.alterpass(session[:username], params[:old_password], params[:new_password],params[:new_password2]) 
    session[:admin] = false     #修改密码如果成功则自动注销，需要重新登录
    redirect to ('/signin')
  rescue Exception => e
    @message = {status: 'danger', desc: e.message }
    erb :alter
  end
end

get '/logoff' do 
  session[:admin] = false
  redirect to '/signin'
end

not_found do
  404
end

error do
  return status
end