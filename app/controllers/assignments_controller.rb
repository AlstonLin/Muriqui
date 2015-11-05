class AssignmentsController < ApplicationController
	before_filter :load_course

	def index
		@assignments = @course.assignments.all
	end

	def create
		@assignment = @course.assignments.build(assignment_params)
		@assignment.course = @course
		respond_to do |format|	
			if @assignment.save
				format.html  { 
					redirect_to @assignment,	
					alert:'Assignment was successfully created.'
				}
	      		format.json  { render :json => @assignment, :status => :created, :location => @assignment }
			else
				format.html  {
					render :action => "new"
				}
	      		format.json  { render :json => @assignment.errors, :status => :unprocessable_entity }
			end
		end
	end	

	def new
		@assignment = @course.assignments.new
	end

	def edit
	end

	def show
		@assignment = @course.assignments.find(params[:id])
	end

	def update
	end 

	def destroy
	end

	def assignment_params
      	params.require(:assignment).permit(:name, :due)
  	end

  	def load_course
  		if (params[:course_id])
  			@course = Course.find(params[:course_id])
  		else
  			@course = Assignment.find(params[:id]).course
  		end
  	end
end
