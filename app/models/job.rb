class Job < ActiveRecord::Base
  validates :title, :description, :presence => true
  # belongs_to :worker
  belongs_to :user
end
