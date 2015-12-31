class ProblemsController < ApplicationController

	def index
		@problem = Problem.find(params[:id])
	end

	def create
		raise "Unauthorized Access! You must be an admin to do this." unless current_user.admin
		@assignment = Assignment.find(params[:assignment_id])
		@problem = @assignment.problems.build(problem_params)
		@problem.assignment = @assignment
		@problem.creator = current_user
	  @problem.generated_source = @problem.generate_source
		save_created_object @problem
	end

	def new
		@assignment = Assignment.find(params[:assignment_id])
		@course = @assignment.course
		@problem = @assignment.problems.build
	end

	def edit
		@problem = Problem.find(params[:id])
		@assignment = @problem.assignment
		@course = @assignment.course
	end

	def update
		raise "Unauthorized Access! You must be an admin to do this." unless current_user.admin
		@problem = Problem.find(params[:id])

		updated = @problem.update_attributes(problem_params)
		if updated
			@problem.generated_source = @problem.generate_source
			save_object @problem
		else
			respond_to do |format|
				format.html  {
					render :text => "An error occured while saving".html_safe
				}
				format.json
			end
		end
	end

	def show
		@problem = Problem.find(params[:id])
		@assignment = @problem.assignment
		@course = @assignment.course
	end

	def problem_params
      params.require(:problem).permit(:number, :part, :source)
  end

	def show_source
		respond_to do |format|
  		format.html { render :text => @problem.source }
  		format.json { render :json => @problem.source }
		end
	end

  	helper_method :show_source
end
