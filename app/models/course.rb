class Course < ActiveRecord::Base
	self.primary_key = 'id'
	validates :code, presence: true
	validates :name, presence: true
	has_many :assignments
end
