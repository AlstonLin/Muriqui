class SourceCode < ActiveRecord::Base
	mount_uploader :attachment, AttachmentUploader
  belongs_to :owner, class_name: "User"
  belongs_to :problem, class_name: "Problem"
  validates :owner, presence: true
  validates :problem, presence: true
end
