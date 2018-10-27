json.extract! post, :id, :user_id, :content, :post_date, :like_count, :created_at, :updated_at
json.url post_url(post, format: :json)
