require 'sinatra'
require 'erb'
require './Msg.rb'
require './MsgManage.rb'

manager = MsgManage.new           #呵 我有对象了

#测试部分 预置内容
Lyrics = ['行走在 冬夜的冷风中',' 飘散的 踩碎的 都是梦',' 孤单单这一刻 如何 确定你曾爱过我 ','停留在冬夜的冷风中 我不是 也不想 装脆弱 ','我没说不代表我不会痛',
    '停留在冬夜的冷风中 我不是 也不想 装脆弱 ','只因为你说过 爱是等待是细水长流 ','Je le sais continue c’est pas bon  ','A la fin turestes pas longtemps',
    '我没说不代表我不会痛']
for i in 0..49 do
  manager.add(Lyrics[i%10],"Jason#{i%8}")
end
#测试部分 预置内容


get '/' do
  @query_msg = manager.msg_array
  if params[:query]==''
    @query_msg = manager.msg_array
  elsif params[:mode]=="id" 
    temp_array = Array.new
    if (temp=manager.search_by_id(params[:query].strip))!=nil #如果返回值nil，则未发现匹配的ID，直接使用空数组
      temp_array.push(temp)
    end
    @query_msg = temp_array
  elsif params[:mode]=="author" 
    @query_msg = manager.search_by_author(params[:query].strip)
  else
    return erb :index
  end
  erb :index
end

get '/add' do 
  erb :add
end

post '/add' do
  #以下实例变量，为判断错误条件所用
  @new_content,@new_author = params[:new_content].strip,params[:new_author].strip
  #点击取消则直接返回首页
  return redirect to ('/') if params[:addCncl] == '取消'
  #判断字数是否符合要求
  if (params[:new_content].strip).length<10 || params[:new_author].strip ==''
    return erb :opFailed 
  end
  #字数符合要求，点击提交之后，进行添加操作
  if params[:addSub] == "提交"
    manager.add(params[:new_content], params[:new_author]) 
    redirect to ('/')
  end
end

get '/delete/:idDelete'  do
  @del_rst = manager.delete(params[:idDelete].to_i)
  erb :deleted
end

get '/edit/:editID' do 
  @allMsg = manager.msg_array
  @editID = params[:editID]
  #如果没有找到该ID，直接渲染编辑失败的模板
  return erb :editNotFound  if manager.search_by_id(params[:editID])==nil 
  msg_need_edit = manager.search_by_id(params[:editID])
  @origin_msg = msg_need_edit.message
  @origin_author = msg_need_edit.author
  erb :edit
end

post '/edit/:editID' do
  return redirect to ('/') if params[:editCncl] == '取消'
  #以下实例变量，为判断错误条件所用
  @new_content,@new_author = params[:editContent].strip,params[:editAuthor].strip
  return erb :opFailed if (params[:editContent].strip).length<10 || params[:editAuthor].strip ==''
  manager.edit(params[:editID], params[:editContent], params[:editAuthor]) if params[:editSub] == "确定"
  redirect to ('/')
end

not_found do
  404
end

error do
  return status
end