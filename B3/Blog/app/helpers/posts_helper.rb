module PostsHelper
  def nickname_finder id
    t = Admin.find_by(id: id)
    p id
    p t
    p Admin.all
    t.nickname
  end
end
