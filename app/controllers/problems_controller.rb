class ProblemsController < ApplicationController
	before_filter :load_assignment

	def index
		@problem = @assignment.find(params[:id])
	end

	def create
		@problem = @assignment.problems.build(problem_params)
		@problem.assignment = @assignment
		respond_to do |format|
			if @problem.save
				format.html  { 
					redirect_to @problem,	
					alert:'Problem was successfully created.'
				}
	      		format.json  { render :json => @problem, :status => :created, :location => @problem }
			else
				format.html  {
					render :action => "new"
				}
	      		format.json  { render :json => @problem.errors, :status => :unprocessable_entity }
			end
		end
	end

	def new
		@problem = @assignment.problems.build
	end

	def edit
	end

	def show
		@problem = @assignment.problems.find(params[:id])
	end

	def update
	end 

	def destroy
	end

	def problem_params
      params.require(:problem).permit(:name)
  	end

  	def load_assignment
  		if (params[:assignment_id])
  			@assignment = Assignment.find(params[:assignment_id])
  		else
  			@assignment = Problem.find(params[:id]).assignment
  		end
  	end
end
