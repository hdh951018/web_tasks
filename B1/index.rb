require 'sinatra'
require 'erb'
require './Msg.rb'
require './MsgManage.rb'

$idnum = 1                      #全局计数变量，在ADD函数里会自增
$allMsg = Array.new             #存储所有留言的数组

#测试部分 预置内容
Lyrics = ['行走在冬夜的冷风中',' 飘散的 踩碎的 都是梦',' 孤单单这一刻 如何 确定你曾爱过我 ','停留在冬夜的冷风中 我不是 也不想 装脆弱 ','我没说不代表我不会痛',
    '停留在冬夜的冷风中 我不是 也不想 装脆弱 ','只因为你说过 爱是等待是细水长流 ','Je le sais continue c’est pas bon  ','A la fin turestes pas longtemps',
    '我没说不代表我不会痛']
for i in 0..49 do
  MsgManage.add($allMsg,Lyrics[i%10],"Jason")
end

$tempMsg = $allMsg

get '/' do
  @queryMsg = $allMsg
  if params[:mode]=="id"
    $tempMsg = MsgManage.searchByID($allMsg, params[:query].lstrip.rstrip)    
  elsif params[:mode]=="author"
    $tempMsg = MsgManage.searchByAuthor($allMsg, params[:query])
  else
    return erb :index
  end
  @queryMsg = $tempMsg  
  erb :index
end

get '/add' do 
  erb :add
end

post '/add' do
  #以下实例变量，为判断错误条件所用
  @newContent,@newAuthor = params[:newContent].lstrip.rstrip,params[:newAuthor].lstrip.rstrip
  #点击取消则直接返回首页
  return redirect to ('/') if params[:addCncl] == '取消'
  #判断字数是否符合要求
  return erb :addFailed if (params[:newContent].lstrip.rstrip).length<10 || params[:newAuthor].lstrip.rstrip ==''
  #字数符合要求，点击提交之后，进行添加操作
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
  #如果没有找到该ID，直接渲染编辑失败的模板
  return erb :editFailed  if MsgManage.searchByID($allMsg,params[:editID])==[]  
  MsgNeedEdit = MsgManage.searchByID($allMsg, params[:editID])
  @originMsg = MsgNeedEdit[0].message
  @originAuthor = MsgNeedEdit[0].author
  erb :edit
end

post '/edit/:editID' do
  return redirect to ('/') if params[:editCncl] == '取消'
  #以下实例变量，为判断错误条件所用
  @newContent,@newAuthor = params[:editContent].lstrip.rstrip,params[:editAuthor].lstrip.rstrip
  return erb :addFailed if (params[:editContent].lstrip.rstrip).length<10 || params[:editAuthor].lstrip.rstrip ==''
  MsgManage.edit($allMsg, params[:editID], params[:editContent], params[:editAuthor]) if params[:editSub] == "确定"
  redirect to ('/')
end

not_found do
  404
end

error do
  return status
end