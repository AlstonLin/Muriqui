class Assignment < ActiveRecord::Base
	self.primary_key = 'id'
	# Relationships
	has_many :problems
	belongs_to :course
	belongs_to :creator, :class_name => 'User', :foreign_key => 'creator_id'
	belongs_to :remover, :class_name => 'User', :foreign_key => 'remover_id'
	# Validation
	validates :name, presence: true
	validates :due, presence: true
	validates :creator, presence: true
end
