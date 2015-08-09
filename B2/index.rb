require 'sinatra'
require 'erb'
require 'active_record'
require 'mysql2'
require './MessageManage.rb'

manager = MsgManager.new
# user = UsrManager.new
after { ActiveRecord::Base.connection.close }

get '/' do
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
  else
    return erb :index
  end
  erb :index
end

get '/add' do 
  erb :add
end

post '/add' do
  return redirect to ('/') if params[:addCncl] == '取消'
  begin
    manager.add(params[:new_content], params[:new_author]) 
    redirect to ('/')
  rescue Exception => e
    @message = {status: 'danger', desc: e.message }
    erb :add
  end
end

get '/delete/:id'  do
  @del_rst = manager.delete(params[:id])
  erb :deleted
end

get '/edit/:id' do 
  @editID = params[:id]
  return '404 <br>NOT FOUND'  if manager.query_by_id(params[:id])==nil ####凑合吧
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

not_found do
  404
end

error do
  return status
end