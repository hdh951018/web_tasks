require 'active_record'
require 'mysql2'
require 'digest/sha1'


class User < ActiveRecord::Base
  has_many :messages
  
  # validates :username,presence:{value: true, message: "请输入用户名"},
  # uniqueness:{value:true, message: "该用户名已存在"},
  # length:{minimum: 6, maximum: 16, message: "用户名长度为6-16个字符"}, #可以在html页面中输入框限制输入长度
  # format:{with:/\A[a-z][0-9a-z]+\Z/, message: "用户名只用由字母和数字组成，且必须是字母开头"}   

end

class UsrManager
  def signup(username,userpassword,userpassword2)    #需要很多检验，包括非法字符，长度，空格等；以及是否有存在的username
    validate(username, userpassword,userpassword2)
    temp = User.new
    temp.username = username
    temp.userpassword = Digest::SHA1.hexdigest(userpassword) #使用SHA1加密后储存密码
    temp.save
  end

  def signin(account,password)          #判断：纯数字就通过id登陆，非纯数字就匹配username
    if account.to_i.to_s == account         #纯数字，通过id登录
      if User.find_by(id: account)==nil
        raise '该ID不存在'
      elsif User.find_by(id: account,userpassword: Digest::SHA1.hexdigest(password))    #进行匹配
        return User.find_by(id: account)
      else
        raise '密码不正确'
      end

    elsif account =~ /[^a-zA-Z0-9]/ || account =~ /^[^a-zA-Z]/    #不符合要求的用户名输入，直接抛出
      raise '请输入正确的用户名'

    else                                    #通过用户名登录
      if account.strip == ''
        raise '请输入用户名'
      elsif User.find_by(username: account)==nil
        raise '该用户名不存在'
      elsif User.find_by(username: account,userpassword: Digest::SHA1.hexdigest(password)) #进行匹配
        return User.find_by(username: account)
      else
        raise '密码不正确'
      end
    end
  end

  def alterpass (username,oldpassword,newpassword,newpassword2)
    temp = User.find_by(username: username,userpassword: Digest::SHA1.hexdigest(oldpassword))
    raise '旧密码不正确' unless temp
    validate("ThisIsOk",newpassword,newpassword2)
    temp.userpassword = Digest::SHA1.hexdigest(newpassword)
    temp.save
  end

  def validate(username,userpassword,userpassword2)
    if username.length<6 
      raise '用户名太短'
    elsif username.length>16
      raise '用户名太长'
    elsif username =~ /[^a-zA-Z0-9]/ || username =~ /^[^a-zA-Z]/              #正则表达 特殊字符
      raise '用户名只用由字母和数字组成，且必须是字母开头'
    elsif User.find_by(username: username)!=nil
      raise '用户名已经被使用'
    elsif userpassword.length>16
      raise '密码长度太长'        #在网页中嵌入长度上限
    elsif userpassword.length<6  
      raise '密码长度太短'      
    elsif userpassword != userpassword2
      raise '两次密码输入不一致'
    end
    true
  end    
end
