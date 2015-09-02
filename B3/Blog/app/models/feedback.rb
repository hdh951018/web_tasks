class Feedback < ActiveRecord::Base
  belongs_to :admin

  validates :email,presence: {value:true, message: "请填写邮箱"},
    length:{maximum: 30,message: "你不要骗我了你的邮箱有这么长？"},
    format:{with: /\A[a-zA-Z0-9._-]+@[a-zA-Z0-9-]+\.[a-zA-Z.]{2,5}\Z/,
      message: "请填写正确的邮箱"}

  validates :content,presence: {value: true, message: "请填写反馈内容"},
    length:{maximum: 500,message: "反馈内容不能超过500字"}
end
