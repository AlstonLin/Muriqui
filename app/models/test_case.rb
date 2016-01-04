class TestCase < ActiveRecord::Base
	self.primary_key = 'id'
	#Relationships
	belongs_to :problem
	belongs_to :creator, :class_name => 'User', :foreign_key => 'creator_id'
	belongs_to :remover, :class_name => 'User', :foreign_key => 'remover_id'
	has_and_belongs_to_many :flaggers, :class_name => 'User'
	#Validation
	validates :input, presence: true
	validates :output, presence: true
	validates :creator, presence: true
	after_save :update_problem_source
	#-------------------------INSTANCE METHODS------------------------------------
	def update_problem_source
		self.problem.update_source!
	end
  
  def get_tests_created_today
    TestCase.where("created_at >= ?", Time.zone.now.beginning_of_day).count
  end
end
