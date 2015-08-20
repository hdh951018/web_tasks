json.array!(@posts) do |post|
  json.extract! post, :id, :title, :content, :cover, :admin_id, :category, :summary
  json.url post_url(post, format: :json)
end
