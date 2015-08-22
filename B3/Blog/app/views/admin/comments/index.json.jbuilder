json.array!(@comments) do |comment|
  json.extract! comment, :id, :post_id, :email, :name, :content, :is_checked
  json.url comment_url(comment, format: :json)
end
