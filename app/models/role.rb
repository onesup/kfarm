class Role < ActiveRecord::Base
  include RoleModel
  has_many :users
end
