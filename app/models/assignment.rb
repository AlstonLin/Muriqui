class Assignment < ActiveRecord::Base
	self.primary_key = 'id'
	belongs_to :course
	has_many :problems 	
	validates :name, presence: true
	validates :due, presence: true
end
