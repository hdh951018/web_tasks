require './Msg.rb'

class MsgManage #留言管理类

  def MsgManage.add(msgArray, messageContent='Nothing', authorName='') #临时版本，和表单交互时再改
    temp = Msg.new
    temp.id = $idnum
    $idnum += 1
    temp.message = messageContent
    temp.author = authorName
    temp.created_at = Time.new
    msgArray.push(temp) #压进数组
    temp.id
  end

  def MsgManage.delete(msgArray, id) #没有重载不开心...哪怕是一个int我也要用数组！！！（内部使用 应该不会传错类型不catch了）
    idArray = Array.new
    if id.is_a?(Integer) 
      idArray. push(id)
    else
      idArray = id
    end
    j = 0 #统计删除个数
    for idTemp in idArray     #在数组中循环
      i = 0
      for x in 0...msgArray.size              
        if msgArray[i].id==idTemp  #匹配id
          msgArray.slice!(i)
          j+=1
          i-=1
        end
        i+=1
      end
    end
    return '该id不存在' if j==0 #该id可能已经被删除了
    j   #返回统计个数
  end

  def MsgManage.searchByID(msgArray,idInput)
    idFound = Array.new
    return idFound if (idInput.to_i.to_s != idInput)
    if idInput.to_i == 0 
      return msgArray          #如果没有传参数，输出所有   
    else    
      for i in 0...msgArray.size
        return idFound.push(msgArray[i])  if msgArray[i].id == idInput.to_i
      end
    end
    idFound
  end

  def MsgManage.searchByAuthor(msgArray,authorInput='0')   ###需要调整
    idFound=Array.new
    if authorInput=='0'           #如果没有传参数，输出所有   
      idFound = msgArray  
    else    
      for i in 0...msgArray.size
#       idFound.push(msgArray[i])   if msgArray[i].author==authorInput    #压进匹配的id数组
        idFound.push(msgArray[i])   if msgArray[i].author.include?authorInput  #模糊查询
      end
    end
    idFound
  end 

  def MsgManage.edit(msgArray, id, editedMessage,editedAuthor)
    editArray = MsgManage.searchByID(msgArray, id)
    editArray[0].message = editedMessage
    editArray[0].author = editedAuthor
  end
end
