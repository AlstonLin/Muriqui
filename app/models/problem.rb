class Problem < ActiveRecord::Base
	self.primary_key = 'id'
	has_many :test_cases
	belongs_to :assignment
	validates :name, presence: true
end
