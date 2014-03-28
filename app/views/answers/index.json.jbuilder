json.array!(@answers) do |answer|
  json.extract! answer, :title, :contents
  json.url answer_url(answer, format: :json)
end
