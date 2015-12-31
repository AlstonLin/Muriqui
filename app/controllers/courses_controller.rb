class CoursesController < ApplicationController

	def index
		@courses = Course.all
		@course = Course.new
	end

	def create
		raise "Unauthorized Access! You must be an admin to do this." unless current_user.admin
		@course = Course.new(course_params)
		@course.creator = current_user
		@courses = Course.all
		save_created_object @course
	end

	def update
		raise "Unauthorized Access! You must be an admin to do this." unless current_user.admin
		#TODO: Make entries editable
	end

	def show
		@course = Course.find(params[:id])
		@assignment = Assignment.new
	end

	def course_params
    params.require(:course).permit(:code, :name)
 	end

	def remove
		raise "Unauthorized Access! You must be an admin to do this." unless current_user.admin
		course = Course.find(params[:course_id])
		@courses = Course.all
		remove_object course
	end
end
