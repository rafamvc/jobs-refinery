require 'paperclip'
  
class JobApplication < ActiveRecord::Base
  HUMANIZED_COLLUMNS = {:resume_file_name => "Resume"}

  def self.human_attribute_name(attribute)
    HUMANIZED_COLLUMNS[attribute.to_sym] || super
  end
  validates_presence_of :name, :phone, :email, :cover_letter
  validates_format_of :email, :with => /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i
  validates_length_of :phone, :is => 10, :message => 'must be 10 digits, excluding special characters such as spaces and dashes. No extension or country code allowed.', :if => Proc.new{|o| !o.phone.blank?}
  validates_format_of :phone, :with => /^[0-9]{3,3}[0-9]{3,3}[0-9]{4,4}$/,:message => "Phone number is not valid. Please type only numbers."
  belongs_to :job, :class_name => "Job", :foreign_key => "job_id"



  has_attached_file :resume
  validates_attachment_presence :resume
  # validates_attachment_content_type :resume, :content_type => ['application/pdf', 'image/jpg', 'application/msword', 'application/doc', 'appl/text', 'application/word', 'application/x-msword']
end
