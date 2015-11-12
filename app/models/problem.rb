class Problem < ActiveRecord::Base
	self.primary_key = 'id'
	has_many :test_cases
	belongs_to :creator, :class_name => 'User'
	belongs_to :assignment
	validates :number, presence: true
	validates :creator, presence: true
	validates :file_name, presence: true
	validates :function_name, presence: true
	validates :source, presence: true
end
