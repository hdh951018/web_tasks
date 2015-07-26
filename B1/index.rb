require 'sinatra'
require 'erb'
require './Msg.rb'
require './MsgManage.rb'

$idnum=1
$allMsg=Array.new




#测试部分 预置内容
for i in 1..5 do
	MsgManage.add($allMsg,"第#{i}条留言内容 
		行走在冬夜的冷风中 飘散的 踩碎的 都是梦 孤单单这一刻 如何 确定你曾爱过我 停留在冬夜的冷风中 我不是 也不想 装脆弱 我没说不代表我不会痛
		停留在冬夜的冷风中 我不是 也不想 装脆弱 只因为你说过 爱是等待是细水长流 Je le sais continue c’est pas bon   A la fin turestes pas longtemps
		我没说不代表我不会痛","第#{i}位Jason")
end


get '/' do
	@allMsg=$allMsg
	erb :index
end
post '/' do
	#筛选
	erb :index
end
get '/add' do 
	erb :add
end

post '/add' do
#	if params[:newContent].length>10 && params[:newAuthor].length!=0 then			#判断是否字数要求，待优化 #我决定还是在html里判断吧
		MsgManage.add($allMsg,params[:newContent],params[:newAuthor]) if params[:submit]=="提交"
		redirect to ('/')
end

get '/delete/:idDelete'  do
#	"I have no idea here #{params[:idDelete]}"
	@delResult=MsgManage.delete($allMsg,params[:idDelete].to_i)
	erb :deleted
end
