require './Msg.rb'

class MsgManage #留言管理类

  def initialize
  @id_total = 1
  @msg_array = Array.new
  end
  attr_reader :msg_array,:id_total

  def add(msg_content='NothingMeaningful', msg_author='Nobody') #临时版本，和表单交互时再改
    temp = Msg.new(@id_total,msg_content,msg_author)
    @id_total += 1
    @msg_array.push(temp) #压进数组
    temp.id
  end

  def delete(id) 
    id_array = Array.new
    if id.is_a?(Integer) 
      id_array. push(id)
    else
      id_array = id
    end
    j = 0 #统计删除个数
    for idTemp in id_array     #在数组中循环
      i = 0
      # for x in 0...@msg_array.size              
      #   if @msg_array[i].id==idTemp  #匹配id
      #     @msg_array.slice!(i)
      #     j+=1
      #     i-=1
      #   end
      #   i+=1
      # end
      @msg_array.size.times do          #取代 for循环产生无用变量 节约内存
        if @msg_array[i].id==idTemp  #匹配id
          @msg_array.slice!(i)
          j+=1
          i-=1
        end
        i+=1
      end
    end
    j   #返回统计个数
  end

  def   search_by_id(id_input)
    return nil if (id_input.to_i.to_s != id_input)  
    for i in 0...@msg_array.size
      return @msg_array[i]  if @msg_array[i].id == id_input.to_i
    end
    nil
  end

  def search_by_author(author_input)   ###需要调整
    found=Array.new
      for i in 0...@msg_array.size
        found.push(@msg_array[i])   if @msg_array[i].author.include?author_input  #模糊查询
      end
    found
  end 

  def edit(id, edited_message,edited_author)
    edit_array = search_by_id(id)
    edit_array.message = edited_message
    edit_array.author = edited_author
  end
end
