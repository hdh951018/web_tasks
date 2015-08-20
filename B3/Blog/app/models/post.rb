class Post < ActiveRecord::Base
  before_save do  
    temp =  ActionController::Base.helpers.strip_tags(self.content)
    self.summary = (temp.strip)[0,20]+"..."
  end

  mount_uploader :cover, CoverUploader  #上传封面图片

  belongs_to :admin
  has_many :comments

  validates :title, presence: {value: true,message: "请输入标题"}, 
  length: { maximum: 16,message: "标题长度不能超过16字" }

  validates :content, presence: {value: true,message: "请输入内容"}, 
  length: { maximum: 100_000,message: "文章内容过长，请适当删减" }

  validates :admin_id, presence:{value: true,message: "获取当前用户失败，请重新登录后尝试"}

  # validates :cover, presence: {value: true,message: "请上传封面"}

  validates :category, presence: {value: true,message: "请选择分类"}

  validates :summary, presence: {value: true,message: "获取文章摘要失败"}

 
end
