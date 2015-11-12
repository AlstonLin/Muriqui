class TestCase < ActiveRecord::Base
	self.primary_key = 'id'
	belongs_to :problem
	belongs_to :creator, :class_name => 'User'
	validates :input, presence: true
	validates :output, presence: true
	validates :creator, presence: true
end
