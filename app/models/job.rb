class Job < ActiveRecord::Base
  validates :title, :description, :presence => true
  # belongs_to :worker
  belongs_to :user

# from james:
  # def toggle_job
  #   self.active = !self.active
  #   self.save
  # end
  #
  # def complete_job
  #   self.completed = true
  #   self.save
  # end
end
