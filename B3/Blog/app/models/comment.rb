class Comment < ActiveRecord::Base
  # before_save do
  #   self.is_checked = false
  # end
  belongs_to :post
  belongs_to :admin

  validates :post_id,presence: {value: true, message: "没有匹配到文章，出现错误"}

  validates :name,presence: {value: true, message: "请填写您的名字"},
    length:{maximum: 20,message: "名字太长了亲"}

  validates :email,presence: {value:true, message: "请填写邮箱"},
    length:{maximum: 30,message: "你不要骗我了你的邮箱有这么长？"},
    format:{with: /\A[a-zA-Z0-9._-]+@[a-zA-Z0-9-]+\.[a-zA-Z.]{2,5}\Z/,
      message: "请填写正确的邮箱"}

  validates :content,presence: {value: true, message: "请填写评论内容"},
    length:{maximum: 140,message: "评论内容不能超过140字"}


end
