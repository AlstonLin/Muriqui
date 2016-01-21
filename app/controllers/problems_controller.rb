class ProblemsController < ApplicationController
	#-----------------------DEFAULT RESTFUL ACTIONS-------------------------------
	def index
		raise "You must be logged in to access this." unless current_user
		@problem = Problem.find(params[:id])
	end

	def create
		raise "Unauthorized Access! You must be an admin to do this." unless current_user.admin
		@assignment = Assignment.find(params[:assignment_id])
		@problem = @assignment.problems.new(problem_params)
		@problem.assignment = @assignment
		@problem.creator = current_user
	  @problem.generated_source = @problem.generate_source
		save_created_object @problem
	end

	def new
		raise "You must be logged in to access this." unless current_user
		@assignment = Assignment.find(params[:assignment_id])
		@course = @assignment.course
		@problem = Problem.new
		@templates = Template.all
	end

	def edit
		raise "You must be logged in to access this." unless current_user
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
		raise "You must be logged in to access this." unless current_user
		@problem = Problem.find(params[:id])
		@assignment = @problem.assignment
		@course = @assignment.course
	end
	#---------------------OTHER RESTFUL ACTIONS-----------------------------------
	def remove
		raise "Unauthorized Access! You must be an admin to do this." unless current_user.admin
		@problem = Problem.find(params[:problem_id])
		@assignment = @problem.assignment
		remove_object @problem
	end

	def get_template
		raise "Unauthorized Access! You must be an admin to do this." unless current_user.admin
		puts "----------------TEMPLATES ID=|" + params[:template_id] + "|-------------------"
		@template = Template.find(params[:template_id])
		respond_to do |format|
			if @template
				format.js
			end
		end
	end
	#---------------------EXTERNALIZED FUNCTIONS----------------------------------
	def problem_params
      params.require(:problem).permit(:number, :part, :source, :instructions)
  end
end
