$idnum=1

class Msg #留言数据类

	@id = 0
	@message='default'
	@author ='default author'
	@created_at = Time.new
	attr_reader :id,:message,:author,:created_at  
       	attr_writer :id,:message,:author,:created_at
end

#Msg=Struct.new(:id,:message,:author,:created_at)  #结构体方式
$allMsg=Array.new

class MsgManage #留言管理类
	
	def MsgManage.add  #临时版本，和表单交互时再改
		temp=Msg.new
		temp.id=$idnum
		$idnum+=1
		p '留言'
		temp.message=gets
		p '作者'
		temp.author=gets
		temp.created_at=Time.new
		p temp
		$allMsg.push(temp) #压进数组
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

	def MsgManage.searchByID(id=0)
		if id==0 then
			p $allMsg			#如果没有传参数，输出所有	
		else	
			for i in 0...$allMsg.size
				if $allMsg[i].id==id
					return $allMsg[i]	
				end
			end
		end
		return 'NothingFound'
	end

	def MsgManage.searchByAuthor(author='default')
		if author=='default' then
			p $allMsg			#如果没有传参数，输出所有	
		else	
			idFound=Array.new
			for i in 0...$allMsg.size
				if $allMsg[i].author==author
					idFound.push($allMsg[i].id)
				end
			end
			return idFound
		end
	end
end

6.times do
MsgManage.add
end
p $allMsg
p '然后开始删除'
p MsgManage.delete([2,4])
p MsgManage.delete([2,4])
p MsgManage.delete(6)
p '开始查询'
p MsgManage.searchByID
p MsgManage.searchByID(1)
p MsgManage.searchByID(8)
p '查询用户'
p MsgManage.searchByAuthor("asd\n")