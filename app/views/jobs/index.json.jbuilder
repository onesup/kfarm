json.array!(@jobs) do |job|
  json.extract! job, :category, :title, :content, :time, :level, :workers_count, :pay, :address, :location, :started_at, :finished_at
  json.url job_url(job, format: :json)
end
