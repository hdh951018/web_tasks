module PostsHelper
  def nickname_finder id
    t = Admin.find_by(id: id)
  end
end
