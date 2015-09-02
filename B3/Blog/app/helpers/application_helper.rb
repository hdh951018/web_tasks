module ApplicationHelper
  def category_list
    category_list = ["默认","编程","文学","小说","情感","日记","笔记"]
  end

  def month_list
    create_time = Post.select("created_at")
    md = Array.new
    for i in 0...create_time.size
      tmd = create_time[i].created_at.strftime("%Y-%m")
      md.push(tmd) unless md.include?(tmd)
    end
    md.sort!.reverse!
  end
end
