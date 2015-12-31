class AssignmentsController < ApplicationController

	def index
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

	def update
		raise "Unauthorized Access! You must be an admin to do this." unless current_user.admin
		#TODO: Make entries editable
	end

	def show
		@assignment = Assignment.find(params[:id])
		@course = @assignment.course
		@problem = Problem.new
	end

	def assignment_params
    params.require(:assignment).permit(:name, :due)
	end

	def remove
		raise "Unauthorized Access! You must be an admin to do this." unless current_user.admin
		@assignment = Assignment.find(params[:assignment_id])
		@course = @assignment.course
		remove_object @assignment
	end

end
