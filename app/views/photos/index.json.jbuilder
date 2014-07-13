json.array!(@photos) do |photo|
  json.extract! photo,
  json.url upload_url(photo, format: :json)
end
