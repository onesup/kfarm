class Application < ActiveRecord::Base
  belongs_to :mentee, class_name: "User"
  belongs_to :job
end
