
class Msg #留言数据类
  def initialize(id,message,author)  
    @id = id
    @message = message
    @author = author
    @created_at = Time.new
  end  

  attr_reader :id, :message, :author, :created_at  
  attr_writer :id, :message, :author, :created_at
end
