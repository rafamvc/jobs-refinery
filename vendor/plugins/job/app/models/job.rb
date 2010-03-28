class Job < ActiveRecord::Base

  acts_as_indexed :fields => [:job_title, :description, :desired_skills, :required_skills, :employment_terms, :hours],
                  :index_file => [Rails.root.to_s, "tmp", "index"]

  validates_presence_of :job_title, :description
  validates_uniqueness_of :job_title
  has_many :job_applications, :class_name => "job_application"
end
