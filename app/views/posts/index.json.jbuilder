json.array!(@posts) do |post|
  json.extract! post, :id, :description, :snippit, :user_id
  json.url post_url(post, format: :json)
end
