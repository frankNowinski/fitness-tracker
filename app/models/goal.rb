class Goal < ActiveRecord::Base
  belongs_to :user
  has_one :entry
end
