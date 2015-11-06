class Assignment < ActiveRecord::Base
	self.primary_key = 'id'
	belongs_to :course
	has_many :problems 	
	belongs_to :creator, :class_name => 'User'
	validates :name, presence: true
	validates :due, presence: true
	validates :creator, presence: true
end
