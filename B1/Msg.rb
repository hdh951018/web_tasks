
class Msg #留言数据类
  @id = 0
  @message = 'default'
  @author = 'default author'
  @created_at = Time.new
  attr_reader :id, :message, :author, :created_at  
  attr_writer :id, :message, :author, :created_at
end
