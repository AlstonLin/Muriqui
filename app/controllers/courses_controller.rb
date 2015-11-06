class CoursesController < ApplicationController

	def index
		@courses = Course.all 
	end

	def create
		@course = Course.new(course_params)
		@creator = current_user
		@course.creator = @creator 
		respond_to do |format|
			if @course.save
				format.html  { 
					redirect_to @course, 
					alert:'Course was successfully created.'
				}
	      		format.json  { render :json => @course, :status => :created, :location => @course }
			else
				format.html  {
					render :action => "new"
				}
	      		format.json  { render :json => @course.errors, :status => :unprocessable_entity }
			end
		end
	end

	def new
		@course = Course.new
	end

	def edit
		@course = Course.find(params[:id])
	end

	def show
		@course = Course.find(params[:id])
	end

	def update
		@course = Course.find(params[:id])
		success = @course.update_attributes(params[:code], params[:name]);
		if success
		else
		end
	end 

	def destroy
		Course.find(params[:id]).destroy
		redirect_to :action => 'index'
	end

	def course_params
      params.require(:course).permit(:code, :name)
   	end
end
