require 'sinatra'
require 'erb'
require 'active_record'
require 'mysql2'
require './MessageManage.rb'
require './UserManage.rb'
require 'sass'

manager = MsgManager.new
usermgr = UsrManager.new
after { ActiveRecord::Base.connection.close }
use Rack::Session::Pool, :expire_after => 120
enable :sessions

get '/' do
  redirect to '/signin' unless session[:admin]==true
  @query_msg = Message.order(:create_time)
  if params[:query]==''
    @query_msg = Message.order(:create_time)
  elsif params[:mode]=="id" 
    temp_array = Array.new
    if (temp=manager.query_by_id(params[:query].strip))!=nil #如果返回值nil，则未发现匹配的ID，直接使用空数组
      temp_array.push(temp)
    end
    @query_msg = temp_array
  elsif params[:mode]=="author" 
    @query_msg = manager.query_by_author(params[:query].strip)
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
    manager.add(params[:new_content], params[:new_author],session[:id]) 
    redirect to ('/')
  rescue Exception => e
    @message = {status: 'danger', desc: e.message }
    erb :add
  end
end

get '/delete/:id'  do
  redirect to '/signin' unless session[:admin]==true
  if manager.query_by_id(params[:id])==nil ||
    manager.query_by_id(params[:id]).user_id != session[:id] #确定是当前用户的留言，否则不予操作
    return '404 <br>NOT FOUND'  
  end  
  erb :deleted
end

get '/edit/:id' do 
  redirect to '/signin' unless session[:admin]==true
  @editID = params[:id]
  if manager.query_by_id(params[:id])==nil ||
    manager.query_by_id(params[:id]).user_id != session[:id]
    return '404 <br>NOT FOUND'  
  end
  msg_need_edit = manager.query_by_id(params[:id])
  @origin_msg = msg_need_edit.msg
  @origin_author = msg_need_edit.author
  erb :edit
end

post '/edit/:id' do
  return redirect to ('/') if params[:editCncl] == '取消'
  begin
    manager.edit(params[:id], params[:editContent], params[:editAuthor]) 
    redirect to ('/')
  rescue Exception => e
    @editID = params[:id]
    @message = {status: 'danger', desc: e.message }
    @origin_msg = params[:editContent]
    @origin_author = params[:editAuthor]
    erb :edit
  end
end

get '/signup' do 
  session[:admin] = false
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

get '/user/:username' do
  redirect to '/signin' unless session[:admin]==true
  @query_msg = manager.query_by_user(session[:username].strip)
  erb :info
end

get '/user/:username/alterpassword' do
  redirect to '/signin' unless session[:admin]==true
  erb :alter
end

post '/user/:username/alterpassword' do
  return redirect to ("/user/#{session[:username]}") if params[:altCncl] == '取消'
  begin
    usermgr.alterpass(session[:username], params[:old_password], params[:new_password],params[:new_password2]) 
    session[:admin] = false
    redirect to ('/signin')
  rescue Exception => e
    @message = {status: 'danger', desc: e.message }
    erb :alter
  end
end

not_found do
  404
end

error do
  return status
end