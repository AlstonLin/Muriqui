class ProblemsController < ApplicationController
	before_filter :load_assignment

	def index
		@problem = @assignment.find(params[:id])
	end

	def create
		@problem = @assignment.problems.build(problem_params)
		@problem.assignment = @assignment
		@problem.creator = current_user
	    @problem.source = generate_source
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
      params.require(:problem).permit(:number, :part, :file_name, :function_name)
  	end

  	def load_assignment
  		if (params[:assignment_id])
  			@assignment = Assignment.find(params[:assignment_id])
  		else
  			@assignment = Problem.find(params[:id]).assignment
  		end
  	end

  	def add_test_case (test_case)
  		@problem = @assignment.problems.find(params[:id])
  		@problem.test_cases << test_case
  		#TODO: MODIFY SOURCE EVERY TIME TEST CASE ADDED
  		if !@problem.save
  			return false
  		end
  		return true
  	end

  	def generate_source
  		#TODO: Finish this template
  		return "#include <stdio.h>  
#include #{@problem.file_name}
void main(){
  printf(\"Hello World\");
}

void #{@problem.function_name}{
}
"
  	end

  	def show_source
  		respond_to do |format|
    		format.html { render :text => @problem.source }
    		format.json { render :json => @problem.source }
  		end
  	end

  	helper_method :show_source
end
