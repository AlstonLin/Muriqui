class TestCasesController < ApplicationController
  TEST_CASE_LIMIT = 10
	#-----------------------DEFAULT RESTFUL ACTIONS-------------------------------
	def index
		raise "You must be logged in to access this." unless current_user
		@problem = Problem.find(params[:problem_id])
		@assignment = @problem.assignment
		@course = @assignment.course
		@test_case = TestCase.new
	end

	def create
		raise "You must be logged in to access this." unless current_user

    @problem = Problem.find(params[:problem_id])
    if current_user.get_tests_created_today < TEST_CASE_LIMIT || current_user.admin
  		@test_case = TestCase.new(test_case_params)
  		@test_case.problem = @problem
  		@test_case.creator = current_user
  		save_created_object @test_case
    else #Limit reached
      flash[:danger] = "You reached your Test Case limit (10) for today."
      respond_to do |format|
        format.js
      end
    end
	end
	#---------------------OTHER RESTFUL ACTIONS-----------------------------------
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

	def remove
		test_case = TestCase.find(params[:test_case_id])
		raise "Unauthorized Access!" unless test_case.creator == current_user || current_user.admin
		@problem = test_case.problem

		test_case.remover = current_user
		test_case.removed = true

		respond_to do |format|
			if test_case.save
        flash[:success] = "Successfully Removed"
				@problem.generated_source = @problem.generate_source
				@problem.save
				format.html  {
					render :text => 'This page should not be shown.'.html_safe
				}
				format.json  { render :json => test_case, :status => :success, :location => test_case }
				format.js
			else
        flash[:danger] = "There was a problem while removing"
				format.html  {
					render :text => "There was an error while removing the Test Case".html_safe
				}
				format.json  { render :json => test_case.errors, :status => :unprocessable_entity }
			end
		end
	end
	#---------------------EXTERNALIZED FUNCTIONS----------------------------------
	def test_case_params
			params.require(:test_case).permit(:input, :output)
	end
end
