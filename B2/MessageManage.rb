require 'active_record'
require 'mysql2'


ActiveRecord::Base.establish_connection(:adapter => "mysql2",
  :host => "127.0.0.1", 
  :username =>"root",
  :password =>"JasonSi",
  :database => "msgboard")  

class Message < ActiveRecord::Base
end


class MsgManager 

  def add(msg,author)
    raise '留言不可以少于十个字' if msg.strip.length <10
    raise '作者不能少于两个字' if author.strip.length <2
    temp = Message.new
    temp.msg = msg.strip  
    temp.author = author.strip
    temp.save
  end

  def delete(id)
    del = Message.find_by(id: id)
    return 0 if del == nil
    del.destroy
    1
  end

  def edit(id,msg,author)
    edt = Message.find_by(id: id)
    raise '留言不可以少于十个字' if msg.strip.length <10
    raise '作者不能少于两个字' if author.strip.length <2
    edt.msg = msg.strip
    edt.author = author.strip
    edt.save    
  end

  def query_by_id(id)
    qid = Message.find_by(id: id) 
  end

  def query_by_author(author)
    qau = Message.where("author = ?",author)
  end
end