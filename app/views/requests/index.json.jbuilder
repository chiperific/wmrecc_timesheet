json.array!(@requests) do |request|
  json.extract! request, :user_id, :date, :hours
  json.url request_url(request, format: :json)
end