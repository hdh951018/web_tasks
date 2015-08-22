# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Post.delete_all
10.times do |i|
  t = Post.new
  t.admin_id = i%3+1
  t.title = "拥抱#{i+1}"
  t.cover = ''
  t.category = "测试"
  t.content = "脱下长日的假面 奔向梦幻的疆界 <br>
    南瓜马车的午夜 换上童话的玻璃鞋 <br>
    让我享受这感觉 我是孤傲的蔷薇 <br>
    让我品尝这滋味 纷乱世界的不了解 <br>
    昨天太近 明天太远 默默聆听那黑夜 <br>
    晚风吻尽 荷花叶 任我醉倒在池边 <br>
    等你清楚看见我的美 月光晒干眼泪 <br>
    那一个人 爱我 <br>
    将我的手 紧握 <br>
    抱紧我 吻我 喔爱~~~ 别走 <br>
    隐藏自己的疲倦 表达自己的狼狈 <br>
    放纵自己的狂野 找寻自己的明天 <br>
    向你要求的誓言 就算是你的谎言 <br>
    我需要爱的慰借 就算那爱已如潮水 <br>
    昨天太近 明天太远 默默聆听那黑夜 <br>
    晚风吻尽 荷花叶 任我醉倒在池边 <br>
    等你清楚看见我的美 月光晒干眼泪 <br>
    那一个人 爱我 <br>
    将我的手 紧握 <br>
    抱紧我 吻我 喔爱~~~ 别走 <br> 
    那一个人 爱我 <br>
    将我的手 紧握 <br>
    抱紧我 吻我 喔爱~~~ 别走 <br>
    抱紧我 吻我 喔爱~~~ 别走 <br>
    抱紧我 吻我 喔爱~~~"
  t.summary = "脱下长日的假面 奔向梦幻的疆界..."
  t.save
end

Comment.delete_all
30.times do |j|
  t = Comment.new
  t.post_id = j%10+1
  t.email = '1234567@qq.com'
  t.name = "评论者"
  t.content = (j%3==1)? "不好听啊" : "这歌不错的"
  t.is_checked = (j%2==1)? true : false
  t.save
end

Admin.delete_all
for x in 1...3
  t = Admin.new
  t.username = "admin#{x}"
  if x == 1
    t.nickname = "战斗鸡排饭"
  else
    t.nickname = "战斗鸡排饭#{x}"
  end
  t.password = "123123"
  t.save
end