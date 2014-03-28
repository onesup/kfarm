json.mentor do
  json.id @user.id
  json.email @user.email 
  json.name @user.name 
  json.phone @user.phone
	json.mentor_guide @user.mentor_guide
end
json.works @works, :id, :category, :title, :contents, :start_time, :finish_time, :working_time, :learning_time, :level, :workers_count, :pay, :address, :created_at, :updated_at, :location, :pretty_started_at, :pretty_finished_at