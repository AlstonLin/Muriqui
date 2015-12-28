class CoursesController < ApplicationController

	def index
		@courses = Course.all
		@course = Course.new
	end

	def create
		raise "Unauthorized Access! You must be an admin to do this." unless current_user.admin
		@course = Course.new(course_params)
		@creator = current_user
		@course.creator = @creator
		@courses = Course.all
		respond_to do |format|
			if @course.save
				format.html  {
					redirect_to @course,
					alert:'Course was successfully created.'
				}
	      format.json  { render :json => @course, :status => :created, :location => @course }
	      format.js
			else
				format.html  {
					render :action => "new"
				}
		    format.json  { render :json => @course.errors, :status => :unprocessable_entity }
			end
		end
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
end
