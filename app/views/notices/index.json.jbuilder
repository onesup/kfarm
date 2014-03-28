json.array!(@notices) do |notice|
  json.extract! notice, :title, :contents
  json.url notice_url(notice, format: :json)
end
