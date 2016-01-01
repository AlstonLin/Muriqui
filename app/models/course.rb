class Course < ActiveRecord::Base
	self.primary_key = 'id'
	#Relationships
	has_many :assignments
	belongs_to :creator, :class_name => 'User', :foreign_key => 'creator_id'
	belongs_to :remover, :class_name => 'User', :foreign_key => 'remover_id'
	#Validation
	validates :code, presence: true
	validates :name, presence: true
	validates :creator, presence: true
end
