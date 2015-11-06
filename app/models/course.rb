class Course < ActiveRecord::Base
	self.primary_key = 'id'
	has_many :assignments
	belongs_to :creator, :class_name => 'User'
	belongs_to :problem
	validates :code, presence: true
	validates :name, presence: true
	validates :creator, presence: true
end
