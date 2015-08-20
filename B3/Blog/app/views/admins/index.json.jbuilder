json.array!(@admins) do |admin|
  json.extract! admin, :id, :username, :nickname, :hashed_password, :salt
  json.url admin_url(admin, format: :json)
end
