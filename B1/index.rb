require 'sinatra'
require 'erb'
require './Msg.rb'
require './MsgManage.rb'

$idnum=1
$allMsg=Array.new




#测试部分 预置内容
for i in 1..5 do
	MsgManage.add($allMsg,"第#{i}条留言内容","第#{i}位留言作者")
end






get '/' do  	
	erb :index
end

get '/add' do 
	erb :add
end

post '/add' do
	MsgManage.add($allMsg,params[:newContent],params[:newAuthor])
	redirect to ('/xxx')
end

get '/xxx' do
	'I have no idea here'
	
end
