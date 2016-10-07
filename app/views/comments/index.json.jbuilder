json.array!(@comments) do |comment|
  json.extract! comment, :id, :comment, :user_id, :post_id
  json.url comment_url(comment, format: :json)
end
