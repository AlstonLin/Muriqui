class TestCasesController < ApplicationController

	def index
		@problem = Problem.find(params[:problem_id])
		@assignment = @problem.assignment
		@course = @assignment.course
		@test_case = TestCase.new
	end

	def create
		@test_case = TestCase.new(test_case_params)
		@problem = Problem.find(params[:problem_id])
		@test_case.problem = @problem
		@test_case.creator = current_user
		save_created_object @test_case
	end

	def update
		test_case = TestCase.find(params[:test_case_id])
		raise "Unauthorized Access! You must be an admin to do this." unless
			current_user.admin || current_user == test_case.creator
		#TODO: Make entries editable
	end

	def test_case_params
      params.require(:test_case).permit(:input, :output)
	end

	def toggle_flag
		raise "Must be logged in to flag a test case!" unless current_user
		test_case = TestCase.find(params[:test_case_id])
		@problem = test_case.problem

		if test_case.flaggers.include?(current_user)
			test_case.flaggers.delete(current_user)
		else
			test_case.flaggers << current_user
		end

		save_object test_case
	end

	helper_method :toggle_flag

	def remove
		test_case = TestCase.find(params[:test_case_id])
		raise "Unauthorized Access!" unless test_case.creator == current_user || current_user.admin
		@problem = test_case.problem

		test_case.remover = current_user
		test_case.removed = true

		respond_to do |format|
			if test_case.save
				@problem.generated_source = @problem.generate_source
				@problem.save
				format.html  {
					render :text => 'This page should not be shown.'.html_safe
				}
				format.json  { render :json => test_case, :status => :success, :location => test_case }
				format.js
			else
				format.html  {
					render :text => "There was an error while removing the Test Case".html_safe
				}
				format.json  { render :json => test_case.errors, :status => :unprocessable_entity }
			end
		end
	end
	helper_method :remove

end
