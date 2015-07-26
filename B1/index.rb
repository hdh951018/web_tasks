require 'sinatra'
require 'erb'
require './Msg.rb'
require './MsgManage.rb'

$idnum = 1                      #全局计数变量，在ADD函数里会自增
$allMsg = Array.new

#测试部分 预置内容
for i in 1..5 do
    MsgManage.add($allMsg, "第#{i}条留言内容 
    	行走在冬夜的冷风中 飘散的 踩碎的 都是梦 孤单单这一刻 如何 确定你曾爱过我 停留在冬夜的冷风中 我不是 也不想 装脆弱 我没说不代表我不会痛
	停留在冬夜的冷风中 我不是 也不想 装脆弱 只因为你说过 爱是等待是细水长流 Je le sais continue c’est pas bon   A la fin turestes pas longtemps
	我没说不代表我不会痛","第#{i}位Jason")
end

=begin
    
rescue Exception => e
    
end
#测试
MsgNeedEdit = MsgManage.searchByID($allMsg, 3)
@originMsg = MsgNeedEdit.message
p @originMsg
=end

get '/' do
    @allMsg = $allMsg
    erb :index
end

post '/' do
    #筛选表单
    erb :index
end

get '/add' do 
    erb :add
end

post '/add' do
    MsgManage.add($allMsg, params[:newContent], params[:newAuthor]) if params[:submit] == "提交"
    redirect to ('/')
end

get '/delete/:idDelete'  do
    @delResult = MsgManage.delete($allMsg, params[:idDelete].to_i)
    erb :deleted
end

get '/edit/:idEdit' do 
    @allMsg = $allMsg
    @idEdit = params[:idEdit]
    return erb :editFailed   if MsgManage.searchByID($allMsg,params[:idEdit].to_i)=='NothingFound'
    MsgNeedEdit = MsgManage.searchByID($allMsg, params[:idEdit].to_i)
    @originMsg = MsgNeedEdit.message
    @originAuthor = MsgNeedEdit.author
    erb :edit
end

post '/edit/:idEdit' do
    MsgManage.edit($allMsg, params[:idEdit].to_i, params[:editContent], params[:editAuthor]) 
    redirect to ('/')
end