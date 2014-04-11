json.array!(@users) do |user|
  json.extract! user, :id, :first_name, :last_name, :status, :created_at
  json.url user_url(user, format: :json)
end
