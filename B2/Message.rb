require 'active_record'
require 'mysql2'


class Message < ActiveRecord::Base
  belongs_to :user
  validates :msg ,presence:{value: true,message: "请输入留言内容"},
    length:{minimum: 10, message: "内容不足十个字"}

  def add(msg, user_id)
    temp = Message.new
    temp.msg = msg.strip  
    temp.user_id = user_id
    temp.save
  end

  def delete(id)
    del = Message.find_by(id: id)
    return 0 if del == nil
    del.destroy
  end

  def edit(id, msg)
    edt = Message.find_by(id: id)
    raise '留言不可以少于十个字' if msg.strip.length <10
    edt.msg = msg.strip
    edt.save    
  end


  def query_by_user(username)
    #增加模糊查询功能
    temp = User.where("username like ?", '%' + username + '%' )
    found = Array.new
    temp.each do |t|
      #将每个user下的messages连接到同一个数组里
      found = found + t.messages
    end
    found
  end  
end
