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
  t.title = "第#{i+1}篇文章"
  t.cover = ''
  t.category = "测试"
  t.content = "脱下长日的假面 奔向梦幻的疆界 
    南瓜马车的午夜 换上童话的玻璃鞋 
    让我享受这感觉 我是孤傲的蔷薇 
    让我品尝这滋味 纷乱世界的不了解 
    昨天太近 明天太远 默默聆听那黑夜 
    晚风吻尽 荷花叶 任我醉倒在池边 
    等你清楚看见我的美 月光晒干眼泪 
    那一个人 爱我 
    将我的手 紧握 
    抱紧我 吻我 喔爱~~~ 别走 
    隐藏自己的疲倦 表达自己的狼狈 
    放纵自己的狂野 找寻自己的明天 
    向你要求的誓言 就算是你的谎言 
    我需要爱的慰借 就算那爱已如潮水 
    昨天太近 明天太远 默默聆听那黑夜 
    晚风吻尽 荷花叶 任我醉倒在池边 
    等你清楚看见我的美 月光晒干眼泪 
    那一个人 爱我 
    将我的手 紧握 
    抱紧我 吻我 喔爱~~~ 别走 
    那一个人 爱我 
    将我的手 紧握 
    抱紧我 吻我 喔爱~~~ 别走 
    抱紧我 吻我 喔爱~~~ 别走 
    抱紧我 吻我 喔爱~~~"
  t.summary = "脱下长日的假面 奔向梦幻的疆界..."
  t.save
end

Comment.delete_all
