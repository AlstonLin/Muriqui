class AssignmentsController < ApplicationController
	#-----------------------DEFAULT RESTFUL ACTIONS-------------------------------
	def index
		raise "You must be logged in to access this." unless current_user
		@assignments = @course.assignments.all
	end

	def create
		raise "Unauthorized Access! You must be an admin to do this." unless current_user.admin
		@course = Course.find(params[:course_id])
		@assignment = @course.assignments.build(assignment_params)
		@assignment.course = @course
		@assignment.creator = current_user
		save_created_object @assignment
	end

	def show
		raise "You must be logged in to access this." unless current_user
		@assignment = Assignment.find(params[:id])
		@course = @assignment.course
		@problem = Problem.new
	end
	#---------------------OTHER RESTFUL ACTIONS-----------------------------------
	def remove
		raise "Unauthorized Access! You must be an admin to do this." unless current_user.admin
		@assignment = Assignment.find(params[:assignment_id])
		@course = @assignment.course
		remove_object @assignment
	end
	#---------------------EXTERNALIZED FUNCTIONS----------------------------------
	def assignment_params
    params.require(:assignment).permit(:name, :due)
	end
end
