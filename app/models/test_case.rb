class TestCase < ActiveRecord::Base
	self.primary_key = 'id'
	belongs_to :problem
	validates :input, presence: true
	validates :output, presence: true
end
