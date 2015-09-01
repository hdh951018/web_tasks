require 'sinatra'
require 'erb'
require 'active_record'
require 'mysql2'
require './Message.rb'
require './User.rb'
require 'sass'
# require 'digest/sha1'

#降低数据库连接频率
ActiveRecord::Base.establish_connection(:adapter => "mysql2",
  :host     => "127.0.0.1", 
  :username => "root",
  :password => "JasonSi",
  :database => "msgboard")  

manager = Message.new
usermgr = UsrManager.new
after { ActiveRecord::Base.connection.close }   #及时断开数据库连接，避免拥堵导致超时
use Rack::Session::Pool, :expire_after => 60*20   #设置Session超时20分钟
enable :sessions

get '/index' do 
  redirect to('/')
end

get '/' do
  redirect to '/signin' unless session[:admin]==true  #判断是否已经登陆，未登录则跳转到登录页面，下同
  @query_msg = Message.order(:create_time)
  if params[:query]==''
    @query_msg = Message.order(:create_time)
  elsif params[:mode]=="id" 
    # temp_array = Array.new
    # if (temp=Message.find_by(id: params[:query].strip))!=nil 
    #   temp_array.push(temp)
    # end

    #直接用where方法查询，查不到返回空数组，省心-。-
    @query_msg = Message.where("id = ?",params[:query])
  elsif params[:mode]=="username" 
    # #先查找是否存在此用户名，若没找到返回空数组，若存在，则通过id搜索相关留言
    # temp = User.find_by(username: params[:query].strip)
    # if temp==nil
    #   @query_msg = []
    # else
    #   @query_msg = Message.where("user_id = ?",temp.id)
    # end
    @query_msg = manager.query_by_user(params[:query])
  else
    return erb :index
  end
  erb :index
end

get '/add' do 
  redirect to '/signin' unless session[:admin]==true
  @new_message = Message.new
  erb :add
end

post '/add' do
  return redirect to ('/') if params[:addCncl] == '取消'
  # begin
  #   manager.add(params[:new_content], session[:id]) 
  #   redirect to ('/')
  # rescue Exception => e
  #   @message = {status: 'danger', desc: e.message }
  #   erb :add
  # end
  @new_message = Message.new
  @new_message.msg = params[:new_content]
  @new_message.user_id = session[:id]
  if @new_message.save
    redirect to "/"
  else
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
  @edit_message = Message.find_by(id: params[:id])
  #防止恶意访问限制url
  if Message.find_by(id: params[:id])==nil ||
    Message.find_by(id: params[:id]).user_id != session[:id]
    return '404 <br>NOT FOUND'  
  end
  params[:editContent] = Message.find_by(id: params[:id]).msg
  erb :edit
end

post '/:username/edit/:id' do
  #加入:username 是为了便于取消时判断返回路径，应该有更好的办法，我不改，我选择死亡。
  if params[:editCncl] == '取消' 
    if params[:username] == 'index'
      redirect to "/"
    else
      redirect to ("/#{params[:username]}")
    end
  end
  # begin
  #   manager.edit(params[:id], params[:editContent]) 
  #   if params[:username] == 'index'
  #     redirect to '/'
  #   else
  #     redirect to ("/#{params[:username]}")
  #   end
  # rescue Exception => e
  #   @editID = params[:id]
  #   @message = {status: 'danger', desc: e.message }
  #   @origin_msg = params[:editContent]
  #   erb :edit
  # end
  @edit_message = Message.find_by(id: params[:id])
  @edit_message.msg = params[:editContent].strip
  if @edit_message.save
    if params[:username] == 'index'
      redirect to '/'
    else
      redirect to ("/#{params[:username]}")
    end
  else
    # @editID = params[:id]
    erb :edit
  end
end

get '/signup' do 
  session[:admin] = false     #注册时关闭session，以免 注册后跳转登录页面 会直接登录原账号
  @new_user = User.new
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

  #由于以前没有使用虚拟属性password，现在改为confirmation验证比较麻烦，所以采用混合验证。太阳。我错了我再也不改了
  # begin
  #   usermgr.validate(params[:new_password],params[:new_password2])
  # rescue Exception => e 
  #   @message = {status: 'danger', desc: e.message }
  #   @new_user = User.new
  #   erb :signup
  # end
  # @new_user = User.new
  # @new_user.username = params[:new_username]
  # @new_user.userpassword = Digest::SHA1.hexdigest(params[:new_password]) #使用SHA1加密后储存密码
  # if @new_user.save
  #   redirect to '/login'
  # else
  #   erb :signup
  # end
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

get '/:username' do
  redirect to '/signin' unless session[:admin]==true
  # @query_msg = manager.query_by_user(session[:username].strip)
  temp = User.find(session[:id])    #改进之前通过用户名find_by，直接通过主键-。-
  @query_msg = temp.messages
  erb :info
end

not_found do
  404
end

error do
  return status
end
