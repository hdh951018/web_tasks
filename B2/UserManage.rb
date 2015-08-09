require 'active_record'
require 'mysql2'


ActiveRecord::Base.establish_connection(:adapter => "mysql2",
  :host => "127.0.0.1", 
  :username =>"root",
  :password =>"JasonSi",
  :database => "msgboard")  

class User < ActiveRecord::Base
end

class UsrManager
  def signup(username,userpassword)    #需要很多检验，包括非法字符，长度，空格等；以及是否有存在的username
    temp = User.new
    temp.username = username
    temp.userpassword = userpassword    #此处要改为加密后保存
    temp.save
  end

  def signin(account,password) #可以考虑另写方法，判断纯数字就通过id登陆，非纯数字就匹配username
  end

end
