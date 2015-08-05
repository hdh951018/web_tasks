
class Msg #留言数据类
  def initialize(id,message,author)  
    if message.strip.length<10 
      raise '内容不能少于10个字'
    elsif  author.strip.length<2
      raise '作者不能少于两个字'
    end
    @id = id
    @message = message
    @author = author
    @created_at = Time.new
  end  

  attr_reader :id, :message, :author, :created_at  
#  attr_writer :id, :message, :author, :created_at

  def message=(val)
    raise '内容不能少于10个字' if val.strip.length<10
    @message = val
  end

  def author=(val)
    raise '作者不能少于两个字' if val.strip.length<2
    @author = val
  end
end
