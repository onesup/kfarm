json.array!(@questions) do |question|
  json.extract! question, :title, :contents, :email
  json.url question_url(question, format: :json)
end
