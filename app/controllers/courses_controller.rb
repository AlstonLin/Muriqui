class CoursesController < ApplicationController
	#-----------------------DEFAULT RESTFUL ACTIONS-------------------------------
	def index
		if current_user
			@courses = Course.order(:code)
			@course = Course.new
		end
	end

	def create
		raise "Unauthorized Access! You must be an admin to do this." unless current_user.admin
		@course = Course.new(course_params)
		@course.creator = current_user
		@courses = Course.all
		save_created_object @course
	end

	def show
		raise "You must be logged in to access this." unless current_user
		@course = Course.find(params[:id])
		@assignment = Assignment.new
	end
	#---------------------OTHER RESTFUL ACTIONS-----------------------------------
	def remove
		raise "Unauthorized Access! You must be an admin to do this." unless current_user.admin
		course = Course.find(params[:course_id])
		@courses = Course.all
		remove_object course
	end
	#---------------------EXTERNALIZED FUNCTIONS----------------------------------
	def course_params
		params.require(:course).permit(:code, :name)
	end
end
