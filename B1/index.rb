require 'sinatra'
require 'erb'
require './Msg.rb'
require './MsgManage.rb'

$idnum = 1                      #全局计数变量，在ADD函数里会自增
$allMsg = Array.new

#测试部分 预置内容
for i in 1..50 do
  MsgManage.add($allMsg, "第#{i}条留言内容 
  	行走在冬夜的冷风中 飘散的 踩碎的 都是梦 孤单单这一刻 如何 确定你曾爱过我 停留在冬夜的冷风中 我不是 也不想 装脆弱 我没说不代表我不会痛
  	停留在冬夜的冷风中 我不是 也不想 装脆弱 只因为你说过 爱是等待是细水长流 Je le sais continue c’est pas bon   A la fin turestes pas longtemps
  	我没说不代表我不会痛","第#{i}位Jason")
end

get '/' do
  @allMsg = $allMsg
#  erb :queryResult
  erb :index
end

post '/' do   #暂时没有实现
  #筛选表单
  @idQuery, @authorQuery = $allMsg
  if params[:mode]=="id"
    @idQuery = MsgManage.searchByID($allMsg, params[:query].to_i)
  elsif params[:mode]=="author"
    @authorQuery = MsgManage.searchByAuthor($allMsg, params[:query])
  else
    return "错误请求"    
  end
end

get '/add' do 
  erb :add
end

post '/add' do
  @newContent,@newAuthor = params[:newContent].lstrip.rstrip,params[:newAuthor].lstrip.rstrip
  return redirect to ('/') if params[:addCncl] == '取消'
  #判断字数是否符合要求
  return erb :addFailed if (params[:newContent].lstrip.rstrip).length<10 || params[:newAuthor].lstrip.rstrip ==''
  #点击提交之后，进行添加操作
  MsgManage.add($allMsg, params[:newContent], params[:newAuthor]) if params[:addSub] == "提交"
  redirect to ('/')
end

get '/delete/:idDelete'  do
  @delResult = MsgManage.delete($allMsg, params[:idDelete].to_i)
  erb :deleted
end

get '/edit/:editID' do 
  @allMsg = $allMsg
  @editID = params[:editID]
  return erb :editFailed  if MsgManage.searchByID($allMsg,params[:editID].to_i)=='NothingFound'
  #如果没有找到该ID，直接渲染编辑失败的模板
  MsgNeedEdit = MsgManage.searchByID($allMsg, params[:editID].to_i)
  @originMsg = MsgNeedEdit.message
  @originAuthor = MsgNeedEdit.author
  erb :edit
end

post '/edit/:editID' do
  @newContent,@newAuthor = params[:editContent].lstrip.rstrip,params[:editAuthor].lstrip.rstrip
  return erb :addFailed if (params[:editContent].lstrip.rstrip).length<10 || params[:editAuthor].lstrip.rstrip ==''
  MsgManage.edit($allMsg, params[:editID].to_i, params[:editContent], params[:editAuthor]) if params[:editSub] == "确定"
  redirect to ('/')
end
