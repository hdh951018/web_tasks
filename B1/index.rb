require 'sinatra'
require 'erb'

$idnum=1
$allMsg=Array.new

class Msg #留言数据类

	@id = 0
	@message='default'
	@author ='default author'
	@created_at = Time.new
	attr_reader :id,:message,:author,:created_at  
       	attr_writer :id,:message,:author,:created_at
end

#Msg=Struct.new(:id,:message,:author,:created_at)  #结构体方式

class MsgManage #留言管理类
	
	def MsgManage.add(messageContent='Nothing',authorName='Nobody') #临时版本，和表单交互时再改
		temp=Msg.new
		temp.id=$idnum
		$idnum+=1
		temp.message=messageContent
		temp.author=authorName
		temp.created_at=Time.new
		$allMsg.push(temp) #压进数组
		p $allMsg#测试 待删
		return temp.id
	end

	def MsgManage.delete(id) #没有重载不开心...哪怕是一个int我也要用数组！！！（内部使用 应该不会传错类型不catch了）
		idArray=Array.new
		if id.is_a?(Integer) then	
			idArray.push(id)
		else
			idArray=id
		end
		j=0 #统计删除个数
		for idTemp in idArray     #在数组中循环
			i=0
			for x in 0...$allMsg.size 				
				if $allMsg[i].id==idTemp  #匹配id
					$allMsg.slice!(i)
					j+=1
					i-=1
				end
				i+=1
			end
		end
		return '该id不存在' if j==0 #该id可能已经被删除了
		return j
	end

	def MsgManage.searchByID(idInput=0)
		if idInput==0 then
			p $allMsg			#如果没有传参数，输出所有	
		else	
			for i in 0...$allMsg.size
				if $allMsg[i].id==idInput
					return $allMsg[i]	
				end
			end
		end
		return 'NothingFound'
	end

	def MsgManage.searchByAuthor(authorInput='default')   ###需要调整
		idFound=Array.new
		if authorInput=='default' then				#如果没有传参数，输出所有	
			idFound=$allMsg	
		else	
			for i in 0...$allMsg.size
				if $allMsg[i].author==authorInput
					idFound.push($allMsg[i])   	#压进匹配的id数组
				end
			end
		end
		return idFound
	end	
end


#测试部分 预置内容
for i in 1..5 do
	MsgManage.add("第#{i}条留言内容","第#{i}位留言作者")
end






get '/' do  	
	erb :index
end

get '/add' do 
	erb :add
end

post '/add' do
	MsgManage.add(params[:newContent],params[:newAuthor])
	redirect to ('/xxx')
end

get '/xxx' do
	'I have no idea here'
	retrun $allMsg
end
