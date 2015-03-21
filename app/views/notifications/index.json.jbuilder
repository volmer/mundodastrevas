json.array!(@notifications) do |notification|
  json.extract! notification, :content, :item_path, :read, :user_id,
                :notifiable_id
  json.url notification_url(notification, format: :json)
end
